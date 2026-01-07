import 'package:dartz/dartz.dart';
import 'package:skin/core/error/failures.dart';
import 'package:skin/features/scan_history/domain/repositories/scan_history_repository.dart';

class DeleteScanUseCase {
  final ScanHistoryRepository repository;

  DeleteScanUseCase(this.repository);

  Future<Either<Failure, void>> call(String scanId, String userId) async {
    return await repository.deleteScan(scanId, userId);
  }
}
