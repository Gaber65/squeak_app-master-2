import '../../domain/entities/beeds_type_data.dart';

class BreedTypeModel extends BreedTypeData {
  BreedTypeModel({super.status, super.message, super.data});

  BreedTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BreedData.fromJson(json['data']) : null;
  }
}

class BreedData extends BreedEnData {
  BreedData({super.breed});

  BreedData.fromJson(Map<String, dynamic> json) {
    if (json['breed'] != null) {
      breed = <Breed>[];
      json['breed'].forEach((v) {
        breed!.add(new Breed.fromJson(v));
      });
    }
  }
}

class Breed extends BreedEn {
  Breed({super.id, super.breedName});

  Breed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    breedName = json['breedName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['breedName'] = this.breedName;
    return data;
  }
}
