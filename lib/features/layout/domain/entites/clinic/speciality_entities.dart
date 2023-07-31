import 'package:equatable/equatable.dart';

import '../../../authentication/login/domain/entities/login.dart';

class SpecialitiesEntities extends Equatable {
  dynamic success;
  Errors? errors;
  List<SpecialitiesData>? data = [];
  dynamic? message;
  int? statusCode;

  SpecialitiesEntities({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  @override
  List<Object?> get props => [success, data, statusCode];
}

class SpecialitiesData extends Equatable {
  const SpecialitiesData({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
