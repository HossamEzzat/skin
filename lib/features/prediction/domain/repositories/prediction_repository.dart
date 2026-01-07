import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/prediction_entity.dart';

abstract class PredictionRepository {
  Future<Either<Failure, PredictionEntity>> predictBurn(File image);
  Future<Either<Failure, PredictionEntity>> predictSkinCancer(File image);
}


