import 'package:squeak/features/authentication/login/data/model/login_model.dart';

import '../../domain/entites/post/get_doctor_post_entitites.dart';
import 'create_post_model.dart';

class PostDoctorModel extends PostDoctorEntities {
  PostDoctorModel({
    super.statusCode,
    super.message,
    super.success,
    super.errors,
    super.data,
  });
  factory PostDoctorModel.fromJson(Map<String, dynamic> json) {
    return PostDoctorModel(
      success: json['success'],
      errors:
          json['errors'] != null ? null : ErrorModel.fromJson(json['errors']),
      data: PostDoctorDataModel.fromJson(json['data']),
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }
}

class PostDoctorDataModel extends PostDoctorData {
  const PostDoctorDataModel({
    required super.getPost,
    required super.countComment,
  });

  factory PostDoctorDataModel.fromJson(Map<String, dynamic> json) {
    return PostDoctorDataModel(
      countComment: json['pageSize'],
      getPost:List.from(json['result']).map((e) => PostsModel.fromJson(e)).toList(),
    );
  }
}
