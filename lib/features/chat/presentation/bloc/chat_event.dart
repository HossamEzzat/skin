import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class FetchChatsRequested extends ChatEvent {}

class FetchMessagesRequested extends ChatEvent {
  final String chatId;
  const FetchMessagesRequested(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class SendMessageRequested extends ChatEvent {
  final String chatId;
  final String text;
  const SendMessageRequested(this.chatId, this.text);

  @override
  List<Object?> get props => [chatId, text];
}

class ChatsUpdated extends ChatEvent {
  final List<ChatEntity> chats;
  const ChatsUpdated(this.chats);

  @override
  List<Object?> get props => [chats];
}

class MessagesUpdated extends ChatEvent {
  final List<MessageEntity> messages;
  const MessagesUpdated(this.messages);

  @override
  List<Object?> get props => [messages];
}

class SearchChatsRequested extends ChatEvent {
  final String query;
  const SearchChatsRequested(this.query);

  @override
  List<Object?> get props => [query];
}
