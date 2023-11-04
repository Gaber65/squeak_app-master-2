import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final bool? status;
  final String? message;
  final int? stateCode;
  final Owner? data;
  Map<String, List<dynamic>>? errors;

  Profile({
    required this.status,
    required this.message,
    required this.data,
    required this.stateCode,
    this.errors,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}

class Owner extends Equatable {
  final String fullName;
  final String userName;
  final String email;
  final String phone;
  final String address;
  final String imageName;
  final String id;
  final String birthdate;
  final int gender;
  final int role;

  const Owner({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.phone,
    required this.address,
    required this.imageName,
    required this.birthdate,
    required this.gender,
    required this.role,
    required this.id,
  });

  @override
  List<Object> get props => [
        fullName,
        userName,
        email,
        phone,
        address,
        imageName,
        id,
        birthdate,
        gender,
        role,
      ];
}
