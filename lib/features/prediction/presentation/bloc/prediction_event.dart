import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class PredictionEvent extends Equatable {
  const PredictionEvent();

  @override
  List<Object> get props => [];
}

class BurnPredictionRequested extends PredictionEvent {
  final File image;

  const BurnPredictionRequested(this.image);

  @override
  List<Object> get props => [image];
}

class SkinCancerPredictionRequested extends PredictionEvent {
  final File image;

  const SkinCancerPredictionRequested(this.image);

  @override
  List<Object> get props => [image];
}

class ResetPrediction extends PredictionEvent {}
