import 'package:equatable/equatable.dart';

class SpeciesEntities extends Equatable {
  final dynamic status;
  final dynamic message;
  final SpeciesData data;

  const SpeciesEntities({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object> get props => [
        status,
        message,
        data,
      ];
}

class SpeciesData extends Equatable {
  final List<BreedSpeciesData> breedSpecies;

  const SpeciesData({
    required this.breedSpecies,
  });

  @override
  List<Object> get props => [breedSpecies];
}

class BreedSpeciesData extends Equatable {
  final String id;
  final String breedName;

  const BreedSpeciesData({
    required this.id,
    required this.breedName,
  });

  @override
  List<Object> get props => [
        id,
        breedName,
      ];
}
