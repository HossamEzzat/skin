import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Stream<Either<Failure, List<ChatEntity>>> getChats();
  Stream<Either<Failure, List<MessageEntity>>> getMessages(String chatId);
  Future<Either<Failure, void>> sendMessage(String chatId, String text);
}


