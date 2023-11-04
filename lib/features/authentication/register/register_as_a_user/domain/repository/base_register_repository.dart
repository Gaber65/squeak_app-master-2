import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/entities/register.dart';

import '../../../register_as_a_doctor/domain/usecase/create_user_use_case.dart';



abstract class BaseRegisterRepository {
  Future<Either<Failure, Register>> getUserRegister(RegisterParameters parameters);


}

class RegisterParameters extends Equatable {

  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String confirmationPassword;


  const RegisterParameters({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmationPassword,
  });

  @override
  List<Object?> get props => [
    fullName,
    email,
    phone,
    password,
    confirmationPassword,
  ];
}
