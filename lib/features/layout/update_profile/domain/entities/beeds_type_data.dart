class BreedTypeData {
  bool? status;
  String? message;
  BreedEnData? data;

  BreedTypeData({this.status, this.message, this.data});
}

class BreedEnData {
  List<BreedEn>? breed;

  BreedEnData({this.breed});
}

class BreedEn {
  String? id;
  String? breedName;

  BreedEn({this.id, this.breedName});
}
