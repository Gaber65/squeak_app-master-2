import 'package:squeak/features/layout/profile/domain/entities/species_entities.dart';

class SpeciesModel extends SpeciesEntities {
  const SpeciesModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory SpeciesModel.fromJson(Map<String, dynamic> json) {
    return SpeciesModel(
      status: json['status'],
      message: json['message'],
      data: SpeciesDataModel.fromJson(
        json['data'],
      ),
    );
  }
}

class SpeciesDataModel extends SpeciesData {
  const SpeciesDataModel({
    required super.breedSpecies,
  });

  factory SpeciesDataModel.fromJson(Map<String, dynamic> json) {
    return SpeciesDataModel(
      breedSpecies: List.from(json['breed'])
          .map((e) => BreedSpeciesDataModel.fromJson(e))
          .toList(),
    );
  }
}

class BreedSpeciesDataModel extends BreedSpeciesData {
  const BreedSpeciesDataModel({
    required super.id,
    required super.breedName,
  });
  factory BreedSpeciesDataModel.fromJson(Map<String, dynamic> json) {
    return BreedSpeciesDataModel(
      id: json['id'],
      breedName: json['breedName'],
    );
  }
}
