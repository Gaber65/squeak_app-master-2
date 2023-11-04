import 'package:squeak/features/layout/data/models/all_clinic_model.dart';
import 'package:squeak/features/layout/domain/entites/clinic/get_follower_clinic_entities.dart';

import '../../../authentication/login/data/model/login_model.dart';

class ClinicFollowersModel extends ClinicFollowersEntities {
  ClinicFollowersModel({
    required super.data,
    required super.statusCode,
    required super.message,
    required super.success,
    required super.errors,
  });

  ClinicFollowersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errors =
        json['errors'] != null ? null : ErrorModel.fromJson(json['errors']);
    data = DataFollowersModel.fromJson(json['data']);
    message = json['message'];
    statusCode = json['statusCode'];
  }
}

class DataFollowersModel extends DataFollowersClinic {
  const DataFollowersModel({
    required super.count,
    required super.clinics,
  });

  factory DataFollowersModel.fromJson(Map<String, dynamic> json) {
    return DataFollowersModel(
      count: json['count'],
      clinics: List.from(json['clinics'])
          .map((e) => ClinicsFollowerModel.fromJson(e))
          .toList(),
    );
  }
}

class ClinicsFollowerModel extends ClinicsFollower {
  ClinicsFollowerModel({required super.id,required super.clinic});
  factory ClinicsFollowerModel.fromJson(Map<String, dynamic> json) {
    return ClinicsFollowerModel(
      id: json['id'],
      clinic: ClinicsModel.fromJson(json['clinic']),
    );
  }
}
