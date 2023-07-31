import 'package:equatable/equatable.dart';

import '../../../authentication/login/domain/entities/login.dart';

class AddClinicEntities extends Equatable {
  dynamic success;
  Errors? errors;
  AddClinicData? data;
  dynamic? message;
  int? statusCode;

  AddClinicEntities({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  @override
  List<Object?> get props => [success, data, statusCode];
}

class AddClinicData extends Equatable {
  final String name;
  final String location;
  final String city;
  final String address;
  final String phone;
  final String speciality;
  final String image;
  final String adminId;

  const AddClinicData({
    required this.name,
    required this.location,
    required this.city,
    required this.address,
    required this.phone,
    required this.speciality,
    required this.adminId,
    required this.image,
  });

  @override
  List<Object> get props => [
        name,
        location,
        city,
        address,
        phone,
        speciality,
        adminId,
      ];
}
