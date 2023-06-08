
class AddNewPetData {
  bool? status;
  String? message;
  DataEn? data;

  AddNewPetData({this.status, this.message, this.data});
}

class DataEn {
  PetsEn? pets;

  DataEn({this.pets});
}

class PetsEn {
  String? petId;
  String? petName;
  int? species;
  String? breedid;
  String? breedName;
  int? gender;
  String? imageName;
  String? birthdate;

  PetsEn(
      {this.petId,
      this.petName,
      this.species,
      this.breedName,
      this.breedid,
      this.gender,
      this.imageName,
      this.birthdate});
}
