import '../../domain/entities/add_peets_data.dart';

class AddNewPetModel extends AddNewPetData {
  AddNewPetModel({super.status, super.message, super.data});

  AddNewPetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data extends DataEn {
  Data({super.pets});

  Data.fromJson(Map<String, dynamic> json) {
    pets = json['Pets'] != null ? new Pets.fromJson(json['Pets']) : null;
  }
}

class Pets extends PetsEn {
  Pets(
      {super.petId,
      super.petName,
      super.species,
      super.breedName,
      super.breedid,
      super.gender,
      super.imageName,
      super.birthdate});

  Pets.fromJson(Map<String, dynamic> json) {
    petId = json['petId'];
    petName = json['petName'];
    species = json['species'];
    breedid = json['breedid'];
    breedName = json['breedName'];
    gender = json['gender'];
    imageName = json['imageName'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petId'] = this.petId;
    data['petName'] = this.petName;
    data['species'] = this.species;
    data['breedid'] = this.breedid;
    data['breedName'] = this.breedName;
    data['gender'] = this.gender;
    data['imageName'] = this.imageName;
    data['birthdate'] = this.birthdate;
    return data;
  }
}
