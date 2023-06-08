class FindPetByOwnerIdData {
  bool? status;
  String? message;
  DataData? data;

  FindPetByOwnerIdData({this.status, this.message, this.data});
}

class DataData {
  List<PetsData>? pets;

  DataData({this.pets});
}

class PetsData {
  String? petId;
  String? petName;
  int? species;
  String? breedName;
  String? breedId;
  int? gender;
  String? imageName;
  String? birthdate;

  PetsData(
      {this.petId,
      this.petName,
      this.species,
      this.breedName,
      this.breedId,
      this.gender,
      this.imageName,
      this.birthdate});
}
