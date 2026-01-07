import 'package:equatable/equatable.dart';
import '../../domain/entities/prediction_entity.dart';

abstract class PredictionState extends Equatable {
  const PredictionState();

  @override
  List<Object> get props => [];
}

class PredictionInitial extends PredictionState {}

class PredictionLoading extends PredictionState {}

class PredictionLoaded extends PredictionState {
  final PredictionEntity prediction;

  const PredictionLoaded(this.prediction);

  @override
  List<Object> get props => [prediction];
}

class PredictionError extends PredictionState {
  final String message;

  const PredictionError(this.message);

  @override
  List<Object> get props => [message];
}


