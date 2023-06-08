import '../../domain/entities/pets_entities.dart';

class PetsModel extends PetsEntities {
  const PetsModel({
    required super.status,
    required super.message,
    required super.data,
  });
  factory PetsModel.fromJson(Map<String, dynamic> json) {
    return PetsModel(
      status: json['status'],
      message: json['message'],
      data: PetsDataModel.fromJson(
        json['data'],
      ),
    );
  }
}

class PetsDataModel extends PetsData {
  const PetsDataModel({required super.breed});
  factory PetsDataModel.fromJson(Map<String, dynamic> json) {
    return PetsDataModel(
      breed: BreedModel.fromJson(json['Pets']),
    );
  }
}

class BreedModel extends Breed {
  const BreedModel({
    required super.petName,
    required super.gender,
    required super.species,
    required super.breedId,
    required super.birthdate,
    required super.image,
    required super.ownerToken,
    required super.imageName,
  });
  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      petName: json['petName'],
      imageName: json['imageName'],
      gender: json['gender'],
      species: json['species'],
      breedId: json['breedid'],
      birthdate: json['birthdate'],
      image: json['image'],
      ownerToken: json['token'],
    );
  }
}

// class BreedIdModel extends BreedId {
//   const BreedIdModel({
//     required super.id,
//     required super.breedName,
//   });
//   factory BreedIdModel.fromJson(Map<String, dynamic> json) {
//     return BreedIdModel(
//       id: json['id'],
//       breedName: json['breedName'],
//     );
//   }
// }
