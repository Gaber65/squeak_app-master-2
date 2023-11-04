import '../../../authentication/login/data/model/login_model.dart';
import '../../domain/entites/clinic/follow_clinic.dart';

class FollowModel extends FollowEntites {
  FollowModel({
    required super.success,
    required super.errors,
    required super.data,
    required super.message,
    required super.statusCode,
  });
  FollowModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errors:
    json['errors'] != null ? null : ErrorModel.fromJson(json['errors']);
    data = json['data'] != {} ?FollowDataModel.fromJson(json['data']) : json['data'];
    message = json['message'];
    statusCode = json['statusCode'];
  }
}

class FollowDataModel extends FollowData {
  FollowDataModel({
    required super.id,
    required super.fullName,
    required super.image,
    required super.gender,
    required super.isBlocked,
    required super.createdAt,
  });
  factory FollowDataModel.fromJson(Map<String, dynamic> json) {
    return FollowDataModel(
      id: json['id'],
      fullName: json['fullName'],
      image: json['image'],
      gender: json['gender'],
      isBlocked: json['isBlocked'],
      createdAt: json['createdAt'],
    );
  }
}
