import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/usecases/get_chats_usecase.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatsUseCase getChatsUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  List<ChatEntity> _allChats = [];

  StreamSubscription? _chatsSubscription;
  StreamSubscription? _messagesSubscription;

  ChatBloc({
    required this.getChatsUseCase,
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
  }) : super(ChatInitial()) {
    on<FetchChatsRequested>(_onFetchChatsRequested);
    on<FetchMessagesRequested>(_onFetchMessagesRequested);
    on<SendMessageRequested>(_onSendMessageRequested);
    on<ChatsUpdated>(_onChatsUpdated);
    on<MessagesUpdated>(_onMessagesUpdated);
    on<SearchChatsRequested>(_onSearchChatsRequested);
  }

  void _onFetchChatsRequested(
    FetchChatsRequested event,
    Emitter<ChatState> emit,
  ) {
    emit(ChatLoading());
    _chatsSubscription?.cancel();
    _chatsSubscription = getChatsUseCase(NoParams()).listen((result) {
      result.fold(
        (failure) => add(const ChatsUpdated([])),
        (chats) => add(ChatsUpdated(chats)),
      );
    });
  }

  void _onFetchMessagesRequested(
    FetchMessagesRequested event,
    Emitter<ChatState> emit,
  ) {
    emit(ChatLoading());
    _messagesSubscription?.cancel();
    _messagesSubscription = getMessagesUseCase(event.chatId).listen((result) {
      result.fold(
        (failure) => add(const MessagesUpdated([])),
        (messages) => add(MessagesUpdated(messages)),
      );
    });
  }

  Future<void> _onSendMessageRequested(
    SendMessageRequested event,
    Emitter<ChatState> emit,
  ) async {
    final result = await sendMessageUseCase(
      SendMessageParams(chatId: event.chatId, text: event.text),
    );
    result.fold(
      (failure) => emit(const ChatError('Failed to send message')),
      (_) => null, // Message list will update via stream
    );
  }

  void _onChatsUpdated(ChatsUpdated event, Emitter<ChatState> emit) {
    _allChats = event.chats;
    emit(ChatsLoaded(event.chats));
  }

  void _onSearchChatsRequested(
    SearchChatsRequested event,
    Emitter<ChatState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(ChatsLoaded(_allChats));
    } else {
      final filtered = _allChats
          .where(
            (chat) =>
                chat.otherUserName.toLowerCase().contains(
                  event.query.toLowerCase(),
                ) ||
                chat.lastMessage.toLowerCase().contains(
                  event.query.toLowerCase(),
                ),
          )
          .toList();
      emit(ChatsLoaded(filtered));
    }
  }

  void _onMessagesUpdated(MessagesUpdated event, Emitter<ChatState> emit) {
    emit(MessagesLoaded(event.messages));
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    _messagesSubscription?.cancel();
    return super.close();
  }
}
