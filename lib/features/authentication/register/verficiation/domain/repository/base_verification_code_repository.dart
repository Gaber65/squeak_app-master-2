import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';

import '../entities/verfication_code.dart';


abstract class BaseVerificationCodeRepository {
  Future<Either<Failure, VerificationCode>> getVerificationCode(VerificationParameters parameters);
}

class VerificationParameters extends Equatable {
  final String verificationToken;

  const VerificationParameters({
    required this.verificationToken,
  });

  @override
  List<Object?> get props => [
    verificationToken,
  ];
}
