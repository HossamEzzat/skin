import 'package:dartz/dartz.dart';
import 'package:skin/core/error/failures.dart';
import 'package:skin/features/scan_history/domain/entities/scan_history_entity.dart';
import 'package:skin/features/scan_history/domain/repositories/scan_history_repository.dart';

class SaveScanUseCase {
  final ScanHistoryRepository repository;

  SaveScanUseCase(this.repository);

  Future<Either<Failure, void>> call(ScanHistoryEntity scan) async {
    return await repository.saveScan(scan);
  }
}
