import 'package:equatable/equatable.dart';

class DiseaseEntity extends Equatable {
  final String id;
  final String name;
  final String scientificName;
  final String overview;
  final String treatment;
  final String mainImage;
  final String scannedImage;
  final List<MedicationEntity> medications;

  const DiseaseEntity({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.overview,
    required this.treatment,
    required this.mainImage,
    required this.scannedImage,
    required this.medications,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    scientificName,
    overview,
    treatment,
    mainImage,
    scannedImage,
    medications,
  ];
}

class MedicationEntity extends Equatable {
  final String id;
  final String name;
  final String image;

  const MedicationEntity({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];
}
