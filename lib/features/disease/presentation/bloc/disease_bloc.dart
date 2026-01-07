import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/disease_data.dart';
import '../../domain/entities/disease_entity.dart';
import 'disease_event.dart';
import 'disease_state.dart';

class DiseaseBloc extends Bloc<DiseaseEvent, DiseaseState> {
  DiseaseBloc() : super(DiseaseInitial()) {
    on<FetchDiseasesRequested>(_onFetchDiseases);
    on<SearchDiseasesRequested>(_onSearchDiseases);
  }

  void _onFetchDiseases(
    FetchDiseasesRequested event,
    Emitter<DiseaseState> emit,
  ) {
    emit(DiseaseLoading());
    try {
      final List<DiseaseEntity> shuffled = List<DiseaseEntity>.from(
        skinDiseases,
      )..shuffle(Random());
      emit(DiseasesLoaded(shuffled));
    } catch (e) {
      emit(const DiseaseError("Failed to fetch diseases"));
    }
  }

  void _onSearchDiseases(
    SearchDiseasesRequested event,
    Emitter<DiseaseState> emit,
  ) {
    if (state is DiseasesLoaded) {
      final query = event.query.toLowerCase();
      if (query.isEmpty) {
        add(FetchDiseasesRequested());
        return;
      }

      final filtered = skinDiseases.where((disease) {
        return disease.name.toLowerCase().contains(query) ||
            disease.scientificName.toLowerCase().contains(query);
      }).toList();
      emit(DiseasesLoaded(filtered));
    } else {
      // If not loaded, fetch all first then filter (simplified)
      final filtered = skinDiseases.where((disease) {
        return disease.name.toLowerCase().contains(event.query.toLowerCase()) ||
            disease.scientificName.toLowerCase().contains(
              event.query.toLowerCase(),
            );
      }).toList();
      emit(DiseasesLoaded(filtered));
    }
  }
}
