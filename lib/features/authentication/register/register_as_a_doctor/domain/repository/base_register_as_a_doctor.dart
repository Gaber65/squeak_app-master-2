import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';

import '../entities/register_as_a_doctor.dart';

abstract class BaseRegisterAsADoctorRepository {
  Future<Either<Failure, RegisterAsADoctor>> getRegisterAsADoctor(RegisterAsADoctorParameters parameters);
}

class RegisterAsADoctorParameters extends Equatable {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String confirmationPassword;
  final int role;


  const RegisterAsADoctorParameters({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmationPassword,
    required this.role,

  });

  @override
  List<Object?> get props => [
    fullName,
    email,
    phone,
    password,
    confirmationPassword,
    role,
  ];
}
