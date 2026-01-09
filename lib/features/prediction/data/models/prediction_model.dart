import 'package:skin/features/prediction/domain/entities/prediction_entity.dart';

class PredictionModel extends PredictionEntity {
  const PredictionModel({
    required super.label,
    required super.confidence,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    // Handle BOTH:
    // Skin disease → { prediction, confidence }
    // Burn        → { burn_level, confidence }

    final label = (json['prediction'] ??
        json['burn_level'] ??
        'Unknown') as String;

    return PredictionModel(
      label: label,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'confidence': confidence,
    };
  }
}
