import 'package:equatable/equatable.dart';

class DiseaseEntity extends Equatable {
  final String id;
  final String name;
  final String scientificName;
  final String severity;
  final bool isContagious;
  final bool isChronic;
  final String overview;
  final String treatment;
  final String mainImage;
  final String scannedImage;
  final List<String> symptoms;
  final List<String> riskFactors;
  final List<String> affectedAreas;
  final List<MedicationEntity> medications;

  const DiseaseEntity({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.severity,
    required this.isContagious,
    required this.isChronic,
    required this.overview,
    required this.treatment,
    required this.mainImage,
    required this.scannedImage,
    required this.symptoms,
    required this.riskFactors,
    required this.affectedAreas,
    required this.medications,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    scientificName,
    severity,
    isContagious,
    isChronic,
    overview,
    treatment,
    mainImage,
    scannedImage,
    symptoms,
    riskFactors,
    affectedAreas,
    medications,
  ];
}

class MedicationEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String image;

  const MedicationEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, description, image];
}
