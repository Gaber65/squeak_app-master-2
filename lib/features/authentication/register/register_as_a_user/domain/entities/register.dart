import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final Data? data;
  final bool status;
  final String? messages;

  const Register({
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

class Data extends Equatable {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final int? role;

  const Data({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    phone,
    role,
  ];
}
