import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final LoginData? data;
  final bool? status;
  final String? messages;

  const Login({
    required this.data,
    required this.status,
    required this.messages,
  });

  @override
  List<Object?> get props => [
        data,
        status,
        messages,
      ];
}

class LoginData extends Equatable {
  final String? token;
  final String? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final int? role;

  const LoginData({
    required this.token,
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
  });

  @override
  List<Object?> get props => [];
}
