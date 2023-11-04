import 'package:squeak/features/setting/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.status,
    required super.message,
    required super.errors,
    required super.data,
    required super.stateCode,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['success'],
      stateCode: json['statusCode'],
      message: json['message'],
      errors: json['errors'] == null
          ? json['errors']
          : Map<String, List<dynamic>>.from(json['errors']),
      data: OwnerModel.fromJson(json['data']['user']),
    );
  }
}

class OwnerModel extends Owner {
  const OwnerModel({
    required super.fullName,
    required super.userName,
    required super.email,
    required super.phone,
    required super.address,
    required super.imageName,
    required super.birthdate,
    required super.gender,
    required super.role,
    required super.id,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      userName: json['userName'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phoneNumber'],
      address: json['address'],
      imageName: json['imageName'],
      birthdate: json['birthDate'],
      gender: json['gender'],
      role: json['userType'],
      id: json['id'],
    );
  }
}
