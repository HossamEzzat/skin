import 'package:equatable/equatable.dart';

class ScanHistoryEntity extends Equatable {
  final String id;
  final String userId;
  final String scanType; // 'skin_cancer' or 'burn'
  final String predictionLabel;
  final double confidence;
  final String imagePath;
  final DateTime timestamp;

  const ScanHistoryEntity({
    required this.id,
    required this.userId,
    required this.scanType,
    required this.predictionLabel,
    required this.confidence,
    required this.imagePath,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    scanType,
    predictionLabel,
    confidence,
    imagePath,
    timestamp,
  ];
}
