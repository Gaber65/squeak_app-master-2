import 'package:equatable/equatable.dart';
import 'package:squeak/features/layout/domain/entites/speciality_entities.dart';

import '../../../authentication/login/domain/entities/login.dart';

class AllClinicEntities extends Equatable {
  dynamic success;
  Errors? errors;
  AllClinicData? data;
  dynamic? message;
  int? statusCode;

  AllClinicEntities({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  @override
  List<Object?> get props => [success, data, statusCode];
}

class AllClinicData extends Equatable {
  final int count;
  List<Clinics> clinics = [];

  AllClinicData({
    required this.count,
    required this.clinics,
  });

  @override
  List<Object> get props => [count];
}

class Clinics extends Equatable {
  final String name;
  final String location;
  final String city;
  final String address;
  final String phone;
  final SpecialitiesData speciality;
  final Admin admin;
  final String clinicId;
  final String image;
  final List<dynamic> availabilities;

  const Clinics({
    required this.name,
    required this.location,
    required this.city,
    required this.address,
    required this.phone,
    required this.speciality,
    required this.admin,
    required this.clinicId,
    required this.image,
    required this.availabilities,
  });

  @override
  List<Object> get props => [
        name,
        location,
        city,
        address,
        phone,
        speciality,
        admin,
        clinicId,
        image,
        availabilities
      ];
}

class Admin extends Equatable {
  final String id;
  final String fullName;
  final String image;
  final int gender;
  final dynamic doctorCode;
  final dynamic specialization;

  const Admin({
    required this.id,
    required this.fullName,
    required this.image,
    required this.gender,
    required this.doctorCode,
    required this.specialization,
  });

  @override
  List<Object> get props => [
        id,
        fullName,
        image,
        gender,
        doctorCode,
        specialization,
      ];
}
