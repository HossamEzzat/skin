import 'package:equatable/equatable.dart';

class PredictionEntity extends Equatable {
  final String label;
  final double confidence;

  const PredictionEntity({required this.label, required this.confidence});

  @override
  List<Object?> get props => [label, confidence];
}


