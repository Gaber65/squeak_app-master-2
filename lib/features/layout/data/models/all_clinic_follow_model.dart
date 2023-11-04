import 'package:squeak/features/authentication/login/data/model/login_model.dart';

import '../../domain/entites/clinic/all_clinic_follower.dart';
import '../../domain/entites/clinic/all_clinics_entities.dart';

class AllClinicFollowModel extends AllClinicFollowerEntities {
  AllClinicFollowModel({
    required super.data,
    required super.statusCode,
    required super.message,
    required super.success,
    required super.errors,
  });

  AllClinicFollowModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errors =
    json['errors'] != null ? null : ErrorModel.fromJson(json['errors']);
    data = AllFollowerDataModel.fromJson(json['data']);
    message =  json['message'];
    statusCode = json['statusCode'];
  }
}

class AllFollowerDataModel extends AllFollowerData {
  AllFollowerDataModel({
    required super.count,
    required super.followers,
  });
  factory AllFollowerDataModel.fromJson(Map<String, dynamic> json) {
    return AllFollowerDataModel(
      count: json['count'],
      followers: List.from(json['followers'])
          .map((e) => ClinicsModel.fromJson(e))
          .toList(),
    );
  }
}

class ClinicsModel extends Followers {
  ClinicsModel({
    required super.fullName,
    required super.id,
    required super.image,
    required super.gender,
    required super.createdAt,
    required super.isBlocked,
  });

  factory ClinicsModel.fromJson(Map<String, dynamic> json) {
    return ClinicsModel(
      fullName: json['fullName'],
      id: json['id'],
      image: json['image'],
      gender: json['gender'],
      createdAt: json['createdAt'],
      isBlocked: json['isBlocked'],
    );
  }
}

class AdminModel extends Admin {
  const AdminModel({
    required super.id,
    required super.fullName,
    required super.image,
    required super.gender,
    required super.doctorCode,
    required super.specialization,
  });
  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      fullName: json['fullName'],
      image: json['image'],
      gender: json['gender'],
      doctorCode: json['doctorCode'],
      specialization: json['specialization'],
    );
  }
}
