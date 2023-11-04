import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final bool status;
  final LoginData? data;
  final dynamic messages;
  final int statusCode;

  const Login({
    required this.data,
    required this.status,
    required this.messages,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [
        status,
        data,
        statusCode,
      ];
}

class LoginData extends Equatable {
  final String token;
  final String refreshToken;
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final int role;

  const LoginData({
    required this.token,
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    required this.refreshToken,
  });

  @override
  List<Object> get props => [
        token,
        id,
        fullName,
        email,
        phone,
        role,
        refreshToken,
      ];
}

class Errors extends Equatable {
  const Errors({
    required this.phone,
    required this.email,
  });

  final List<String> phone;
  final List<String> email;

  @override
  List<Object> get props => [
        phone,
        email,
      ];
}
