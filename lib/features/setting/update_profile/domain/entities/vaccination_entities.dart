import 'package:equatable/equatable.dart';

import '../../../../authentication/login/domain/entities/login.dart';

class VacEntities extends Equatable {
  dynamic success;
  Errors? errors;
  List<VacEntitiesData>? data = [];
  dynamic? message;
  int? statusCode;

  VacEntities({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  @override
  List<Object?> get props => [success, data, statusCode];
}

class VacEntitiesData extends Equatable {
  final String vaccinationName;
  final String id;

  const VacEntitiesData({
    required this.vaccinationName,
    required this.id,
  });

  @override
  List<Object> get props => [vaccinationName, id];
}
