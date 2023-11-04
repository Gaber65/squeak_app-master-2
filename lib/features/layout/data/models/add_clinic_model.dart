import 'package:squeak/features/layout/domain/entites/clinic/add_clinic_entities.dart';

import '../../../authentication/login/data/model/login_model.dart';

class AddClinicEntitiesModel extends AddClinicEntities {
  AddClinicEntitiesModel({
    required super.success,
    required super.errors,
    required super.data,
    required super.message,
    required super.statusCode,
  });
  AddClinicEntitiesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errors = json['errors'] == null ? json['errors'] : Map<String, List<dynamic>>.from(json['errors']);

    data = AddClinicDataModel.fromJson(json['data']);
    message = json['message'];
    statusCode = json['statusCode'];
  }
}

class AddClinicDataModel extends AddClinicData {
  AddClinicDataModel({
    required super.name,
    required super.location,
    required super.city,
    required super.address,
    required super.phone,
    required super.speciality,
    required super.adminId,
    required super.image,
  });
  factory AddClinicDataModel.fromJson(Map<String, dynamic> json) {
    return AddClinicDataModel(
      name: json['name'],
      location: json['location'],
      city: json['city'],
      address: json['address'],
      phone: json['phone'],
      speciality: json['speciality'],
      adminId: json['adminId'],
      image: json['image'],
    );
  }
}
