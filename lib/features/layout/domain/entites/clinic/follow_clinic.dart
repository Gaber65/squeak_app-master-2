import 'package:equatable/equatable.dart';

import '../../../../core/service/server_error.dart';

class FollowEntites {
  dynamic success;
  Errors? errors;
  FollowData? data;
  dynamic? message;
  int? statusCode;

  FollowEntites({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  List<Object?> get props => [success, data, statusCode];
}

class FollowData extends Equatable {
  FollowData({
    required this.id,
    required this.fullName,
    required this.image,
    required this.gender,
    required this.isBlocked,
    required this.createdAt,
  });

  final String id;
  final dynamic fullName;
  final dynamic image;
  final dynamic gender;
  final bool isBlocked;
  final String createdAt;

  @override
  List<Object> get props => [
        id,
        fullName,
        image,
        gender,
        isBlocked,
        createdAt,
      ];
}
