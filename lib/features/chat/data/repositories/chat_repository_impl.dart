import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/error/exceptions.dart';
import 'package:skin/features/chat/domain/entities/chat_entity.dart';
import 'package:skin/features/chat/domain/entities/message_entity.dart';
import 'package:skin/features/chat/domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Stream<Either<Failure, List<ChatEntity>>> getChats() {
    return remoteDataSource
        .getChats()
        .map<Either<Failure, List<ChatEntity>>>((models) => Right(models))
        .handleError((_) => Left(ServerFailure()));
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getMessages(String chatId) {
    return remoteDataSource
        .getMessages(chatId)
        .map<Either<Failure, List<MessageEntity>>>((models) => Right(models))
        .handleError((_) => Left(ServerFailure()));
  }

  @override
  Future<Either<Failure, void>> sendMessage(String chatId, String text) async {
    if (!await networkInfo.isConnected) return Left(NetworkFailure());
    try {
      await remoteDataSource.sendMessage(chatId, text);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}


