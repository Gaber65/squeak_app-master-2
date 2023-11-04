import '../../domain/entities/login.dart';

class LoginModel extends Login {
  const LoginModel({
    required super.data,
    required super.status,
    required super.messages,
    required super.statusCode,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      data: json['success'] == true ? LoginDataModel.fromJson(json['data']) : json['data'],
      status: json['success'],
      messages: json['message'],
      statusCode: json['statusCode'],
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
    required super.refreshToken,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      token: json['token'],
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      refreshToken: json['refreshToken'],
    );
  }
}

class ErrorModel extends Errors {
  const ErrorModel({
    required super.phone,
    required super.email,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      phone: List.castFrom<dynamic, String>(json['Phone']),
      email: List.castFrom<dynamic, String>(json['Email']),
    );
  }
}
