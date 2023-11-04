
import '../../domain/entities/update_profile.dart';

class UpdateProfileModel extends UpdateProfile {
  const UpdateProfileModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UpdateProfileDataModel.fromJson(json['data']) : null,
    );
  }
}

class UpdateProfileDataModel extends UpdateProfileData {
  const UpdateProfileDataModel({
    required super.owner,
  });

  factory UpdateProfileDataModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileDataModel(
      owner: json['owner'] != null
          ? UpdateProfileOwnerModel.fromJson(json['owner'])
          : null,
    );
  }
}

class UpdateProfileOwnerModel extends UpdateProfileOwner {
  const UpdateProfileOwnerModel({
    required super.clientId,
    required super.fullname,
    required super.email,
    required super.phone,
    required super.addresss,
    required super.imageName,
    required super.gender,
    required super.locked,
    required super.role,
  });

  factory UpdateProfileOwnerModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileOwnerModel(
      clientId: json['clientId'],
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      addresss: json['addresss'],
      imageName: json['imageName'],
      gender: json['gender'],
      locked: json['locked'],
      role: json['role'],
    );
  }
}
