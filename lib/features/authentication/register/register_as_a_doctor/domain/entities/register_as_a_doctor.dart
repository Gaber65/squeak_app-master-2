import 'package:equatable/equatable.dart';

class RegisterAsADoctor extends Equatable {
  final DataAsADoctor? data;
  final bool status;
  final String? messages;

  const RegisterAsADoctor({
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

class DataAsADoctor extends Equatable {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final int? role;

  const DataAsADoctor({
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
