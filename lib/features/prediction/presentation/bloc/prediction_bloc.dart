import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin/features/scan_history/domain/entities/scan_history_entity.dart';
import 'package:skin/features/scan_history/domain/usecases/save_scan_usecase.dart';
import '../../domain/usecases/predict_burn_usecase.dart';
import '../../domain/usecases/predict_skin_cancer_usecase.dart';
import 'prediction_event.dart';
import 'prediction_state.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  final PredictBurnUseCase predictBurnUseCase;
  final PredictSkinCancerUseCase predictSkinCancerUseCase;
  final SaveScanUseCase saveScanUseCase;
  final FirebaseAuth firebaseAuth;

  PredictionBloc({
    required this.predictBurnUseCase,
    required this.predictSkinCancerUseCase,
    required this.saveScanUseCase,
    required this.firebaseAuth,
  }) : super(PredictionInitial()) {
    on<BurnPredictionRequested>(_onBurnPredictionRequested);
    on<SkinCancerPredictionRequested>(_onSkinCancerPredictionRequested);
  }

  Future<void> _onBurnPredictionRequested(
    BurnPredictionRequested event,
    Emitter<PredictionState> emit,
  ) async {
    emit(PredictionLoading());
    final result = await predictBurnUseCase(event.image);

    await result.fold(
      (failure) async {
        emit(const PredictionError('Classification failed. Please try again.'));
      },
      (prediction) async {
        // Save to scan history
        final user = firebaseAuth.currentUser;
        if (user != null) {
          final scanHistory = ScanHistoryEntity(
            id: '${user.uid}_${DateTime.now().millisecondsSinceEpoch}',
            userId: user.uid,
            scanType: 'burn',
            predictionLabel: prediction.label,
            confidence: prediction.confidence,
            imagePath: event.image.path,
            timestamp: DateTime.now(),
          );
          await saveScanUseCase(scanHistory);
        }

        emit(PredictionLoaded(prediction));
      },
    );
  }

  Future<void> _onSkinCancerPredictionRequested(
    SkinCancerPredictionRequested event,
    Emitter<PredictionState> emit,
  ) async {
    emit(PredictionLoading());
    final result = await predictSkinCancerUseCase(event.image);

    await result.fold(
      (failure) async {
        emit(const PredictionError('Classification failed. Please try again.'));
      },
      (prediction) async {
        // Save to scan history
        final user = firebaseAuth.currentUser;
        if (user != null) {
          final scanHistory = ScanHistoryEntity(
            id: '${user.uid}_${DateTime.now().millisecondsSinceEpoch}',
            userId: user.uid,
            scanType: 'skin_cancer',
            predictionLabel: prediction.label,
            confidence: prediction.confidence,
            imagePath: event.image.path,
            timestamp: DateTime.now(),
          );
          await saveScanUseCase(scanHistory);
        }

        emit(PredictionLoaded(prediction));
      },
    );
  }
}
