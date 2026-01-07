import 'package:dartz/dartz.dart';
import 'package:skin/core/error/failures.dart';
import 'package:skin/features/scan_history/domain/entities/scan_history_entity.dart';
import 'package:skin/features/scan_history/domain/repositories/scan_history_repository.dart';

class GetUserScansUseCase {
  final ScanHistoryRepository repository;

  GetUserScansUseCase(this.repository);

  Future<Either<Failure, List<ScanHistoryEntity>>> call(String userId) async {
    return await repository.getUserScans(userId);
  }
}
