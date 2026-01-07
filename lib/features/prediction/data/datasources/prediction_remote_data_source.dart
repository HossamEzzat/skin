import 'dart:io';
import '../models/prediction_model.dart';

abstract class PredictionRemoteDataSource {
  Future<PredictionModel> predictBurn(File image);
  Future<PredictionModel> predictSkinCancer(File image);
}


