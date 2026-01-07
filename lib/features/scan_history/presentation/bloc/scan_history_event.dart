import 'package:equatable/equatable.dart';

abstract class ScanHistoryEvent extends Equatable {
  const ScanHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadScanHistory extends ScanHistoryEvent {
  final String userId;

  const LoadScanHistory(this.userId);

  @override
  List<Object?> get props => [userId];
}

class DeleteScan extends ScanHistoryEvent {
  final String scanId;
  final String userId;

  const DeleteScan({required this.scanId, required this.userId});

  @override
  List<Object?> get props => [scanId, userId];
}

class RefreshScanHistory extends ScanHistoryEvent {
  final String userId;

  const RefreshScanHistory(this.userId);

  @override
  List<Object?> get props => [userId];
}
