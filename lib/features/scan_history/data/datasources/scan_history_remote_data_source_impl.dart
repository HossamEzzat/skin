import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skin/features/scan_history/data/datasources/scan_history_remote_data_source.dart';
import 'package:skin/features/scan_history/data/models/scan_history_model.dart';

class ScanHistoryRemoteDataSourceImpl implements ScanHistoryRemoteDataSource {
  final FirebaseFirestore firestore;

  ScanHistoryRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> saveScan(ScanHistoryModel scan) async {
    try {
      await firestore
          .collection('scan_history')
          .doc(scan.id)
          .set(scan.toJson());
    } catch (e) {
      throw Exception('Failed to save scan: $e');
    }
  }

  @override
  Future<List<ScanHistoryModel>> getUserScans(String userId) async {
    try {
      final querySnapshot = await firestore
          .collection('scan_history')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => ScanHistoryModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get user scans: $e');
    }
  }

  @override
  Future<void> deleteScan(String scanId, String userId) async {
    try {
      // Verify the scan belongs to the user before deleting
      final doc = await firestore.collection('scan_history').doc(scanId).get();

      if (doc.exists && doc.data()?['userId'] == userId) {
        await firestore.collection('scan_history').doc(scanId).delete();
      } else {
        throw Exception('Scan not found or unauthorized');
      }
    } catch (e) {
      throw Exception('Failed to delete scan: $e');
    }
  }
}
