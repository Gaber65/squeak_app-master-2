import 'package:squeak/features/authentication/login/data/model/login_model.dart';

import '../../domain/entities/find_pet_by_owner_id_data.dart';

class FindPetByOwnerIdModel extends FindPetByOwnerIdData {
  FindPetByOwnerIdModel({
    required super.data,
    required super.statusCode,
    required super.message,
    required super.success,
    required super.errors,
  });

  FindPetByOwnerIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errors =
        json['errors'] != null ? null : ErrorModel.fromJson(json['errors']);
    data =
        List.from(json['data']['petsDto']).map((e) => PetsDataModel.fromJson(e)).toList();
    message = null;
    statusCode = json['statusCode'];
  }
}

class PetsDataModel extends PetsData {
  const PetsDataModel({
    required super.petId,
    required super.petName,
    required super.breedId,
    required super.gender,
    required super.imageName,
    required super.birthdate,
  });
  factory PetsDataModel.fromJson(Map<String, dynamic> json) {
    return PetsDataModel(
      petId: json['id'],
      petName: json['petName'],
      breedId: json['breedId'],
      gender: json['gender'],
      imageName: json['imageName'],
      birthdate: json['birthdate'],
    );
  }
}
