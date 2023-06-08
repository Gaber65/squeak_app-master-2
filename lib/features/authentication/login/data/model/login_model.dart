import '../../domain/entities/login.dart';

class LoginModel extends Login {
  const LoginModel({
    required super.data,
    required super.status,
    required super.messages,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      data: json['data'] != null ? LoginDataModel.fromJson(json['data']) : null,
      status: json['status'],
      messages: json['messages'],
    );
  }
}

class LoginDataModel extends LoginData {
  const LoginDataModel({
    required super.token,
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.role,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      token: json['token'],
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}
