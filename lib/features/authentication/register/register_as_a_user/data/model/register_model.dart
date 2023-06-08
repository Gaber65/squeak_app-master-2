import 'package:squeak/features/authentication/register/register_as_a_user/domain/entities/register.dart';

class RegisterModel extends Register {
  const RegisterModel({
    required super.data,
    required super.status,
    required super.messages,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      data: json['data'] != null ? DataModel.fromJson(json['data']) : null,
      status: json['status'],
      messages: json['messages'],
    );
  }
}

class DataModel extends Data {
  const DataModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.role,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}
