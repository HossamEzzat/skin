import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';

class GetChatsUseCase implements StreamUseCase<List<ChatEntity>, NoParams> {
  final ChatRepository repository;

  GetChatsUseCase(this.repository);

  @override
  Stream<Either<Failure, List<ChatEntity>>> call(NoParams params) {
    return repository.getChats();
  }
}


