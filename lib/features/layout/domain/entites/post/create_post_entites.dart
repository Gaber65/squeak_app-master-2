import 'package:equatable/equatable.dart';

import '../../../../authentication/login/domain/entities/login.dart';

class PostEntities extends Equatable {
  dynamic success;
  Map<String, List<dynamic>>?  errors;
  PostData? data;
  dynamic message;
  int? statusCode;

  PostEntities({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
    this.data,
  });

  @override
  List<Object?> get props => [success, data, statusCode];
}

class PostData extends Equatable {


  final dynamic count;
  List<Posts>? getPost;
  Posts? createPost ;


  PostData({
    required this.count,
    this.getPost,
    this.createPost
  });

  @override
  List<Object?> get props => [
        count,
      ];
}

class Posts extends Equatable {

  final String title;
  final String content;
  final dynamic? image;
  final dynamic postId;
  final dynamic video;
  final ClinicPost? clinicPost;
  final SpeciePost? speciePost;

  const Posts({
    required this.title,
    required this.content,
    required this.video,
    required this.clinicPost,
    required this.speciePost,
    this.postId,
    this.image,

  });

  @override
  List<Object?> get props => [
        title,
        content,
        image,
        video,
        clinicPost,
        speciePost,
      ];
}

class ClinicPost extends Equatable {
  final String name;
  final String location;
  final String city;
  final String address;
  final String phone;
  final dynamic code;
  final dynamic image;

  const ClinicPost({
    required this.name,
    required this.location,
    required this.city,
    required this.address,
    required this.phone,
    required this.image,
    required this.code,
  });

  @override
  List<Object> get props => [
        name,
        location,
        city,
        address,
        phone,
      ];
}

class SpeciePost extends Equatable {
  final String arType;
  final String enType;

  const SpeciePost({
    required this.arType,
    required this.enType,
  });

  @override
  List<Object> get props => [
        enType,
        arType,
      ];
}
