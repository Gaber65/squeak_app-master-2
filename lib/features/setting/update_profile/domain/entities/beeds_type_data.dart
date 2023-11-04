import 'package:equatable/equatable.dart';

import '../../../../authentication/login/domain/entities/login.dart';

class BreedEntities extends Equatable {
  dynamic success;
  Errors? errors;
  List<BreadData>? data = [];
  dynamic message;
  int? statusCode;

  BreedEntities({
    this.data,
    this.statusCode,
    this.message,
    this.success,
    this.errors,
  });

  @override
  List<Object?> get props => [success, data, statusCode];
}

class BreadData extends Equatable {
  final String enType;
  final String id;

  const BreadData({
    required this.enType,
    required this.id,
  });

  @override
  List<Object> get props => [enType, id];
}
