import 'package:dartz/dartz.dart';
import 'package:skin/core/error/failures.dart';
import 'package:skin/core/network/network_info.dart';
import 'package:skin/features/scan_history/data/datasources/scan_history_remote_data_source.dart';
import 'package:skin/features/scan_history/data/models/scan_history_model.dart';
import 'package:skin/features/scan_history/domain/entities/scan_history_entity.dart';
import 'package:skin/features/scan_history/domain/repositories/scan_history_repository.dart';

class ScanHistoryRepositoryImpl implements ScanHistoryRepository {
  final ScanHistoryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ScanHistoryRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> saveScan(ScanHistoryEntity scan) async {
    if (await networkInfo.isConnected) {
      try {
        final model = ScanHistoryModel.fromEntity(scan);
        await remoteDataSource.saveScan(model);
        return const Right(null);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<ScanHistoryEntity>>> getUserScans(
    String userId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final scans = await remoteDataSource.getUserScans(userId);
        return Right(scans);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteScan(String scanId, String userId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteScan(scanId, userId);
        return const Right(null);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
