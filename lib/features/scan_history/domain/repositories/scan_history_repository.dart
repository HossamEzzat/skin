import 'package:dartz/dartz.dart';
import 'package:skin/core/error/failures.dart';
import 'package:skin/features/scan_history/domain/entities/scan_history_entity.dart';

abstract class ScanHistoryRepository {
  Future<Either<Failure, void>> saveScan(ScanHistoryEntity scan);
  Future<Either<Failure, List<ScanHistoryEntity>>> getUserScans(String userId);
  Future<Either<Failure, void>> deleteScan(String scanId, String userId);
}
