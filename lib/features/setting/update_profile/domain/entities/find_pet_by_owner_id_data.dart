import 'package:equatable/equatable.dart';

import '../../../../authentication/login/domain/entities/login.dart';

class FindPetByOwnerIdData extends Equatable {
  dynamic success;
  Errors? errors;
  List<PetsData>? data = [];
  dynamic? message;
  int? statusCode;

  FindPetByOwnerIdData(
      {this.statusCode, this.message, this.data, this.errors, this.success});

  @override
  List<Object> get props => [success, message];
}

class PetsData extends Equatable {
  final dynamic petId;
  final String petName;
  final String breedId;
  final int gender;
  final dynamic imageName;
  final String birthdate;

  const PetsData({
    required this.petId,
    required this.petName,
    required this.breedId,
    required this.gender,
    required this.imageName,
    required this.birthdate,
  });

  @override
  List<Object> get props => [
        petId,
        petName,
        breedId,
        gender,
        imageName,
        birthdate,
      ];

  factory PetsData.fromJson(Map<String, dynamic> json) {
    return PetsData(
      petId: json['petId'],
      petName: json['petName'],
      breedId: json['breedId'],
      gender: json['gender'],
      imageName: json['imageName'],
      birthdate: json['birthdate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'petId': petId,
      'petName': petName,
      'breedId': breedId,
      'gender': gender,
      'imageName': imageName,
      'birthdate': birthdate,
    };
  }
}
