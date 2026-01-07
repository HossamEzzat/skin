import 'package:equatable/equatable.dart';
import '../../domain/entities/disease_entity.dart';

abstract class DiseaseState extends Equatable {
  const DiseaseState();

  @override
  List<Object?> get props => [];
}

class DiseaseInitial extends DiseaseState {}

class DiseaseLoading extends DiseaseState {}

class DiseasesLoaded extends DiseaseState {
  final List<DiseaseEntity> diseases;

  const DiseasesLoaded(this.diseases);

  @override
  List<Object?> get props => [diseases];
}

class DiseaseError extends DiseaseState {
  final String message;

  const DiseaseError(this.message);

  @override
  List<Object?> get props => [message];
}
