import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/features/layout/domain/entites/clinic/all_clinics_entities.dart';

import '../../../../authentication/login/domain/entities/login.dart';

class ClinicFollowersEntities extends Equatable {
  dynamic success;
  Errors? errors;
  DataFollowersClinic? data;
  dynamic? message;
  int? statusCode;

  ClinicFollowersEntities({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  @override
  List<Object?> get props => [
        success,
        data,
        statusCode,
      ];
}

class DataFollowersClinic extends Equatable {
  const DataFollowersClinic({
    required this.count,
    required this.clinics,
  });

  final int count;
  final List<ClinicsFollower> clinics;

  @override
  List<Object> get props => [count, clinics];

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'clinics': clinics,
    };
  }
}

class ClinicsFollower extends Equatable {
  const ClinicsFollower({
    required this.id,
    required this.clinic,
  });

  final String id;
  final Clinics clinic;

  @override
  List<Object> get props => [id,clinic];
}
