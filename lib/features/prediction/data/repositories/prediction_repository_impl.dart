import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import 'package:skin/features/prediction/domain/entities/prediction_entity.dart';
import 'package:skin/features/prediction/domain/repositories/prediction_repository.dart';
import '../datasources/prediction_remote_data_source.dart';

class PredictionRepositoryImpl implements PredictionRepository {
  final PredictionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PredictionRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PredictionEntity>> predictBurn(File image) async {
    return await _getPrediction(() => remoteDataSource.predictBurn(image));
  }

  @override
  Future<Either<Failure, PredictionEntity>> predictSkinCancer(
    File image,
  ) async {
    return await _getPrediction(
      () => remoteDataSource.predictSkinCancer(image),
    );
  }

  Future<Either<Failure, PredictionEntity>> _getPrediction(
    Future<PredictionEntity> Function() getPrediction,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePrediction = await getPrediction();
        return Right(remotePrediction);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}


