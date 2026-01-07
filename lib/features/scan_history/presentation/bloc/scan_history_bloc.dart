import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin/features/scan_history/domain/usecases/delete_scan_usecase.dart';
import 'package:skin/features/scan_history/domain/usecases/get_user_scans_usecase.dart';
import 'package:skin/features/scan_history/presentation/bloc/scan_history_event.dart';
import 'package:skin/features/scan_history/presentation/bloc/scan_history_state.dart';

class ScanHistoryBloc extends Bloc<ScanHistoryEvent, ScanHistoryState> {
  final GetUserScansUseCase getUserScansUseCase;
  final DeleteScanUseCase deleteScanUseCase;

  ScanHistoryBloc({
    required this.getUserScansUseCase,
    required this.deleteScanUseCase,
  }) : super(ScanHistoryInitial()) {
    on<LoadScanHistory>(_onLoadScanHistory);
    on<DeleteScan>(_onDeleteScan);
    on<RefreshScanHistory>(_onRefreshScanHistory);
  }

  Future<void> _onLoadScanHistory(
    LoadScanHistory event,
    Emitter<ScanHistoryState> emit,
  ) async {
    emit(ScanHistoryLoading());

    final result = await getUserScansUseCase(event.userId);

    result.fold(
      (failure) => emit(ScanHistoryError(_mapFailureToMessage(failure))),
      (scans) => emit(ScanHistoryLoaded(scans)),
    );
  }

  Future<void> _onDeleteScan(
    DeleteScan event,
    Emitter<ScanHistoryState> emit,
  ) async {
    // Keep current state while deleting
    final currentState = state;

    final result = await deleteScanUseCase(event.scanId, event.userId);

    result.fold(
      (failure) => emit(ScanHistoryError(_mapFailureToMessage(failure))),
      (_) {
        // Refresh the list after successful deletion
        if (currentState is ScanHistoryLoaded) {
          final updatedScans = currentState.scans
              .where((scan) => scan.id != event.scanId)
              .toList();
          emit(ScanHistoryLoaded(updatedScans));
        }
      },
    );
  }

  Future<void> _onRefreshScanHistory(
    RefreshScanHistory event,
    Emitter<ScanHistoryState> emit,
  ) async {
    // Don't show loading on refresh
    final result = await getUserScansUseCase(event.userId);

    result.fold(
      (failure) => emit(ScanHistoryError(_mapFailureToMessage(failure))),
      (scans) => emit(ScanHistoryLoaded(scans)),
    );
  }

  String _mapFailureToMessage(failure) {
    return failure.toString();
  }
}
