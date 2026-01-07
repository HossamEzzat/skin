import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/article_entity.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleEntity>>> getArticles();
}


