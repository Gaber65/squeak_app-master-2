import 'package:equatable/equatable.dart';

import '../../../../authentication/login/domain/entities/login.dart';
import 'create_post_entites.dart';

class PostDoctorEntities extends Equatable {
  dynamic success;
  Errors? errors;
  PostDoctorData? data;
  dynamic message;
  int? statusCode;

  PostDoctorEntities({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  @override
  List<Object?> get props => [success, data, statusCode];
}

class PostDoctorData extends Equatable {
  final List<Posts> getPost;
  final dynamic countComment;

  const PostDoctorData({
    required this.getPost,
    required this.countComment,
  });

  @override
  List<Object?> get props => [countComment];
}



