import '../../../../authentication/login/data/model/login_model.dart';
import '../../domain/entities/add_peets_data.dart';

class AddNewPetModel extends AddNewPetData {
  AddNewPetModel({
    required super.data,
    required super.statusCode,
    required super.success,
    required super.message,
    required super.errors,
  });

  AddNewPetModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] == null
        ? json['data']
        : PetDataModel.fromJson(json['data']);
    message = json['message'];
    errors = json['errors'] == null ? json['errors'] :Map<String, List<dynamic>>.from(json['errors']);

    statusCode = json['statusCode'];
  }
}

class PetDataModel extends PetData {
  const PetDataModel({
    required super.petId,
    required super.petName,
    required super.gender,
    required super.breedId,
    required super.imageName,
    required super.birthdate,
  });

  factory PetDataModel.fromJson(Map<String, dynamic> json) {
    return PetDataModel(
      petId: json['petId'],
      petName: json['petName'],
      gender: json['gender'],
      imageName: json['imageName'],
      breedId: json['breedId'],
      birthdate: json['birthdate'],
    );
  }
}
