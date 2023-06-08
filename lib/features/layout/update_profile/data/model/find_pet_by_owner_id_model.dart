import '../../domain/entities/find_pet_by_owner_id_data.dart';

class FindPetByOwnerIdModel extends FindPetByOwnerIdData {
  FindPetByOwnerIdModel({super.status, super.message, super.data});

  FindPetByOwnerIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['messages'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data extends DataData {
  // List<Pets>? pets;

  Data({super.pets});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Pets'] != null) {
      pets = <Pets>[];
      json['Pets'].forEach((v) {
        pets!.add(new Pets.fromJson(v));
      });
    }
  }
}

class Pets extends PetsData {
  String? petId;
  String? petName;
  int? species;
  String? breedName;
  String? breedId;
  int? gender;
  String? imageName;
  String? birthdate;

  Pets(
      {super.petId,
      super.petName,
      super.species,
      super.breedName,
      super.breedId,
      super.gender,
      super.imageName,
      super.birthdate});

  Pets.fromJson(Map<String, dynamic> json) {
    petId = json['petId'];
    petName = json['petName'];
    species = json['species'];
    breedName = json['breedName'];
    breedId = json['breedId'];
    gender = json['gender'];
    imageName = json['imageName'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petId'] = this.petId;
    data['petName'] = this.petName;
    data['species'] = this.species;
    data['breedName'] = this.breedName;
    data['breedId'] = this.breedId;
    data['gender'] = this.gender;
    data['imageName'] = this.imageName;
    data['birthdate'] = this.birthdate;
    return data;
  }
}
