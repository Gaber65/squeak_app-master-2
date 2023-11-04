import 'package:equatable/equatable.dart';

import '../../../../authentication/login/domain/entities/login.dart';

class AddNewPetData extends Equatable {
  dynamic success;
  Map<String, List<dynamic>>?  errors;
  PetData? data ;
  dynamic? message;
  int? statusCode;

  AddNewPetData({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  @override
  List<Object?> get props => [success, data, statusCode];
}

class PetData extends Equatable {
  final dynamic petId;
  final String petName;
  final int gender;
  final String breedId;
  final String imageName;
  final String birthdate;

  const PetData({
    required this.petId,
    required this.petName,
    required this.gender,
    required this.breedId,
    required this.imageName,
    required this.birthdate,
  });

  @override
  List<Object> get props => [
        petId,
        petName,
        gender,
        breedId,
        imageName,
        birthdate,
      ];
}
