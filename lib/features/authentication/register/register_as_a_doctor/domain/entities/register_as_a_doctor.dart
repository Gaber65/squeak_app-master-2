import 'package:equatable/equatable.dart';
import 'package:squeak/features/authentication/login/domain/entities/login.dart';

class RegisterAsADoctor extends Equatable {
  final bool status;
  final Map<String, List<dynamic>>  errors;
  final dynamic data;
  final dynamic messages;

  final int statusCode;

  const RegisterAsADoctor({
    required this.data,
    required this.status,
    required this.messages,
    required this.statusCode,
    required this.errors,
  });

  @override
  List<Object> get props => [
    status,
    data,
    statusCode,
  ];
}

class DataAsADoctor extends Equatable {
  final String token;
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final int role;

  const DataAsADoctor({
    required this.token,
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
  });

  @override
  List<Object> get props => [
    token,
    id,
    fullName,
    email,
    phone,
    role,
  ];
}
