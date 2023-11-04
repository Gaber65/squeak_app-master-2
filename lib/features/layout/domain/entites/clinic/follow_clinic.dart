import 'package:equatable/equatable.dart';

import '../../../../authentication/login/domain/entities/login.dart';


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
  const FollowData({
    required this.id,
    required this.fullName,
    required this.image,
    required this.gender,
    required this.isBlocked,
    required this.createdAt,
  });

  final dynamic id;
  final dynamic fullName;
  final dynamic image;
  final dynamic gender;
  final dynamic isBlocked;
  final dynamic createdAt;

  Map<String, dynamic> toMap()
  {
    return {
      'id':id,
      'fullName':fullName,
      'image':image,
      'gender':gender,
      'isBlocked':isBlocked,
      'createdAt':createdAt,
    };
  }
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
