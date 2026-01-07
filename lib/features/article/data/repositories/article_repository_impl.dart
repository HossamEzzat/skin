import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/error/exceptions.dart';
import 'package:skin/features/article/domain/entities/article_entity.dart';
import 'package:skin/features/article/domain/repositories/article_repository.dart';
import 'package:skin/features/article/data/datasources/article_remote_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles() async {
    if (!await networkInfo.isConnected) return Left(NetworkFailure());
    try {
      final models = await remoteDataSource.getArticles();
      return Right(models);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}


