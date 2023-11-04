import 'package:squeak/features/authentication/register/register_as_a_user/domain/entities/register.dart';

import '../../../../login/data/model/login_model.dart';

class RegisterModel extends Register {
  const RegisterModel({
    required super.data,
    required super.status,
    required super.messages,
    required super.statusCode,
    required super.errors,
  });
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      data:json['data'],
      status: json['success'],
      messages: json['message'],
      errors: Map<String, List<dynamic>>.from(json['errors']),
      statusCode: json['statusCode'],
    );
  }
}

class DataModel extends Data {
  const DataModel({
    required super.token,
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.role,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      token: json['token'],
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      role: json['userType'],
    );
  }
}
