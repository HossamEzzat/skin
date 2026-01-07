import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/prediction_entity.dart';
import '../repositories/prediction_repository.dart';

class PredictBurnUseCase implements UseCase<PredictionEntity, File> {
  final PredictionRepository repository;

  PredictBurnUseCase(this.repository);

  @override
  Future<Either<Failure, PredictionEntity>> call(File image) async {
    return await repository.predictBurn(image);
  }
}


