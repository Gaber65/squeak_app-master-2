import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/exception.dart';
import 'package:squeak/core/error/failure.dart';

import '../../domain/entities/verfication_code.dart';
import '../../domain/repository/base_verification_code_repository.dart';
import '../datasource/base_verification_code_remote_use_case.dart';

class VerificationCodeRepository extends BaseVerificationCodeRepository
{
  final BaseVerificationCodeRemoteUseCase baseVerificationCodeRemoteUseCase;

  VerificationCodeRepository(this.baseVerificationCodeRemoteUseCase);
  @override
  Future<Either<Failure, VerificationCode>> getVerificationCode(VerificationParameters parameters)async {
    final result = await baseVerificationCodeRemoteUseCase.getVerificationCode(parameters);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

}