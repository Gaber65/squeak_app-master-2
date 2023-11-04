import 'package:equatable/equatable.dart';

import '../../../../authentication/login/domain/entities/login.dart';

class SpeciesEntities extends Equatable {
  dynamic success;
  Errors? errors;
  List<SpeciesData>? data = [];
  dynamic? message;
  int? statusCode;

  SpeciesEntities({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  @override
  List<Object?> get props => [success, data, statusCode];
}

class SpeciesData extends Equatable {
  final String enType;
  final String id;

  const SpeciesData({
    required this.enType,
    required this.id,
  });

  @override
  List<Object> get props => [enType, id];
}
