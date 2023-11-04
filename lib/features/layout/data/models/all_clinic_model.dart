import 'package:squeak/features/authentication/login/data/model/login_model.dart';
import 'package:squeak/features/layout/data/models/specialities_model.dart';

import '../../domain/entites/clinic/all_clinics_entities.dart';

class AllClinicModel extends AllClinicEntities {
  AllClinicModel({
    required super.data,
    required super.statusCode,
    required super.message,
    required super.success,
    required super.errors,
  });

  AllClinicModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errors =
        json['errors'] != null ? null : ErrorModel.fromJson(json['errors']);
    data = json['data'] == null
        ? json['data']
        : AllClinicDataModel.fromJson(json['data']);
    message = json['message'];
    statusCode = json['statusCode'];
  }
}

class AllClinicDataModel extends AllClinicData {
  AllClinicDataModel({
    required super.count,
    required super.clinics,
  });
  factory AllClinicDataModel.fromJson(Map<String, dynamic> json) {
    return AllClinicDataModel(
      count: json['count'],
      clinics:json['result'] == null ? json['result'] : List.from(json['result']).map((e) => ClinicsModel.fromJson(e)).toList(),
    );
  }
}

class ClinicsModel extends Clinics {
  const ClinicsModel({
    required super.name,
    required super.location,
    required super.city,
    required super.code,
    required super.address,
    required super.phone,
    required super.speciality,
    required super.admin,
    required super.clinicId,
    required super.image,
    required super.availabilities,
  });
  factory ClinicsModel.fromJson(Map<String, dynamic> json) {
    return ClinicsModel(
      name: json['name'],
      location: json['location'],
      code: json['code'],
      city: json['city'],
      address: json['address'],
      phone: json['phone'],
      speciality: List.from(json['specialities']).map((e) => SpecialitiesDataModel.fromJson(e)).toList(),
      admin:  json['admin'] == null ? null :  AdminModel.fromJson(json['admin']),
      clinicId: json['id'],
      image: json['image'],
      availabilities: List.castFrom<dynamic, dynamic>(json['availabilities']),
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
