import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skin/features/scan_history/domain/entities/scan_history_entity.dart';

class ScanHistoryModel extends ScanHistoryEntity {
  const ScanHistoryModel({
    required super.id,
    required super.userId,
    required super.scanType,
    required super.predictionLabel,
    required super.confidence,
    required super.imagePath,
    required super.timestamp,
  });

  factory ScanHistoryModel.fromJson(Map<String, dynamic> json) {
    return ScanHistoryModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      scanType: json['scanType'] as String,
      predictionLabel: json['predictionLabel'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      imagePath: json['imagePath'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'scanType': scanType,
      'predictionLabel': predictionLabel,
      'confidence': confidence,
      'imagePath': imagePath,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory ScanHistoryModel.fromEntity(ScanHistoryEntity entity) {
    return ScanHistoryModel(
      id: entity.id,
      userId: entity.userId,
      scanType: entity.scanType,
      predictionLabel: entity.predictionLabel,
      confidence: entity.confidence,
      imagePath: entity.imagePath,
      timestamp: entity.timestamp,
    );
  }
}
