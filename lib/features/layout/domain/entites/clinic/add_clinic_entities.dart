import 'package:equatable/equatable.dart';

import '../../../../authentication/login/domain/entities/login.dart';

class AddClinicEntities extends Equatable {
  dynamic success;
  Map<String, List<dynamic>>? errors;
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
  final dynamic name;
  final dynamic location;
  final dynamic city;
  final dynamic address;
  final dynamic phone;
  final dynamic speciality;
  final dynamic image;
  final dynamic adminId;

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
  List<Object?> get props => [
        phone,
        speciality,
        adminId,
      ];
}
