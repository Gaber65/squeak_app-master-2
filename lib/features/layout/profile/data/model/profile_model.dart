import 'package:squeak/features/layout/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'],
      message: json['message'],
      data: ProfileDataModel.fromJson(json['data']),
    );
  }
}

class ProfileDataModel extends ProfileData {
  const ProfileDataModel({
    required super.owner,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      owner: json['owner'] != null ? OwnerModel.fromJson(json['owner']) : null,
    );
  }
}

class OwnerModel extends Owner {
  const OwnerModel({
    required super.clientId,
    required super.fullname,
    required super.email,
    required super.phone,
    required super.addresss,
    required super.imageName,
    required super.birthdat,
    required super.gender,
    required super.locked,
    required super.role,
    required super.language,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      clientId: json['clientId'],
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      addresss: json['addresss'],
      imageName: json['imageName'],
      birthdat: json['birthdat'],
      gender: json['gender'],
      locked: json['locked'],
      role: json['role'],
      language: json['language'],
    );
  }
}
