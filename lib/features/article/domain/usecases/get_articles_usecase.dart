import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/article_entity.dart';
import '../repositories/article_repository.dart';

class GetArticlesUseCase implements UseCase<List<ArticleEntity>, NoParams> {
  final ArticleRepository repository;

  GetArticlesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParams params) async {
    return await repository.getArticles();
  }
}


