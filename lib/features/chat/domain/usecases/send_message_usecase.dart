import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase implements UseCase<void, SendMessageParams> {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    return await repository.sendMessage(params.chatId, params.text);
  }
}

class SendMessageParams extends Equatable {
  final String chatId;
  final String text;

  const SendMessageParams({required this.chatId, required this.text});

  @override
  List<Object?> get props => [chatId, text];
}


