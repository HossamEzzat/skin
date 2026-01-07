import 'package:skin/features/prediction/domain/entities/prediction_entity.dart';

class PredictionModel extends PredictionEntity {
  const PredictionModel({required super.label, required super.confidence});

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    // Handling different potential JSON structures from the Flask API
    final prediction = json['predictions'][0];
    return PredictionModel(
      label: prediction['class'] ?? 'Unknown',
      confidence: (prediction['confidence'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'label': label, 'confidence': confidence};
  }
}


