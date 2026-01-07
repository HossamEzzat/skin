import 'package:skin/features/scan_history/data/models/scan_history_model.dart';

abstract class ScanHistoryRemoteDataSource {
  /// Save a scan to Firestore
  Future<void> saveScan(ScanHistoryModel scan);

  /// Get all scans for a specific user
  Future<List<ScanHistoryModel>> getUserScans(String userId);

  /// Delete a specific scan
  Future<void> deleteScan(String scanId, String userId);
}
