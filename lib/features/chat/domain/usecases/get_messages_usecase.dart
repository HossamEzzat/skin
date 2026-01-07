import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

class GetMessagesUseCase implements StreamUseCase<List<MessageEntity>, String> {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  @override
  Stream<Either<Failure, List<MessageEntity>>> call(String chatId) {
    return repository.getMessages(chatId);
  }
}


