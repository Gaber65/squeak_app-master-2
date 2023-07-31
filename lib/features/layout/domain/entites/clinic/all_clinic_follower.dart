import 'package:equatable/equatable.dart';
import 'package:squeak/features/layout/domain/entites/speciality_entities.dart';

import '../../../authentication/login/domain/entities/login.dart';

class AllClinicFollowerEntities extends Equatable {
  dynamic success;
  Errors? errors;
  AllFollowerData? data;
  dynamic? message;
  int? statusCode;

  AllClinicFollowerEntities({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  @override
  List<Object?> get props => [success, data, statusCode];
}

class AllFollowerData extends Equatable {
  final int count;
  List<Followers> followers = [];

  AllFollowerData({
    required this.count,
    required this.followers,
  });

  @override
  List<Object> get props => [count];
}

class Followers extends Equatable {
  final dynamic fullName;
  final dynamic id;
  final dynamic image;
  final dynamic gender;
  final dynamic isBlocked;
  final dynamic createdAt;

  const Followers({
    required this.fullName,
    required this.id,
    required this.image,
    required this.gender,
    required this.createdAt,
    required this.isBlocked,

  });

  @override
  List<Object> get props =>
      [fullName, id, image, gender, isBlocked, createdAt,];


}

