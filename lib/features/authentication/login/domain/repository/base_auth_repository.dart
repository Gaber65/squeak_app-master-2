import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';

import '../entities/forget_password.dart';
import '../entities/login.dart';
import '../entities/reset_password.dart';

abstract class BaseLoginRepository {
  Future<Either<Failure, Login>> getUserLogin(LoginParameters parameters);

  Future<Either<Failure, ForgetPassword>> getForgetPassword(
      ForgetPasswordParameters parameters);

  Future<Either<Failure, ResetPassword>> getResetPassword(
      ResetPasswordParameters parameters);
}

class LoginParameters extends Equatable {
  final String email;
  final String password;

  const LoginParameters({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [
        email,
        password,
      ];
}

class ForgetPasswordParameters extends Equatable {
  final String email;

  const ForgetPasswordParameters({
    required this.email,
  });

  @override
  List<Object?> get props =>
      [
        email,
      ];
}

class ResetPasswordParameters extends Equatable {
  final String token;
  final String password;
  final String confirmNewPassword;
  final String email;

  const ResetPasswordParameters({
    required this.token,
    required this.password,
    required this.email,
    required this.confirmNewPassword,
  });

  @override
  List<Object?> get props => [token, password, email];
}
