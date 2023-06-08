import '../../domain/entities/owner_pets.dart';

class OwnerPetsEntitiesModel extends OwnerPetsEntities {
  const OwnerPetsEntitiesModel({
    required super.status,
    required super.message,
    required super.data,
  });
  factory OwnerPetsEntitiesModel.fromJson(Map<String, dynamic> json) {
    return OwnerPetsEntitiesModel(
      status: json['status'],
      message: json['message'],
      data: OwnerPetsDataModel.fromJson(
        json['data'],
      ),
    );
  }
}

class OwnerPetsDataModel extends OwnerPetsData {
  const OwnerPetsDataModel({required super.breed});
  factory OwnerPetsDataModel.fromJson(Map<String, dynamic> json) {
    return OwnerPetsDataModel(
      breed: List.from(
        json['Pets'],
      )
          .map(
            (e) => OwnerBreedModel.fromJson(e),
          )
          .toList(),
    );
  }
}

class OwnerBreedModel extends OwnerBreed {
  const OwnerBreedModel({
    required super.petName,
    required super.gender,
    required super.species,
    required super.breedId,
    required super.birthdate,
    required super.image,
    required super.imageName,
    required super.breedName,
    required super.petId,
  });
  factory OwnerBreedModel.fromJson(Map<String, dynamic> json) {
    return OwnerBreedModel(
      petName: json['petName'],
      gender: json['gender'],
      species: json['species'],
      breedId: json['breedId'],
      birthdate: json['birthdate'],
      image: json['image'],
      imageName: json['imageName'],
      breedName: json['breedName'],
      petId: json['petId'],
    );
  }
}
