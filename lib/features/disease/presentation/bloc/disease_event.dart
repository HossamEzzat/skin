import 'package:equatable/equatable.dart';

abstract class DiseaseEvent extends Equatable {
  const DiseaseEvent();

  @override
  List<Object?> get props => [];
}

class FetchDiseasesRequested extends DiseaseEvent {}

class SearchDiseasesRequested extends DiseaseEvent {
  final String query;

  const SearchDiseasesRequested(this.query);

  @override
  List<Object?> get props => [query];
}
