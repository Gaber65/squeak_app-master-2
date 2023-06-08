import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/exception.dart';
import 'package:squeak/core/error/failure.dart';


import '../../domain/entities/forget_password.dart';
import '../../domain/entities/login.dart';
import '../../domain/entities/reset_password.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../datasource/base_login_remote_data_source.dart';

class LoginRepository extends BaseLoginRepository
{
  final BaseLoginRemoteDataSource baseLoginRemoteDataSource;

  LoginRepository(this.baseLoginRemoteDataSource);
  @override
  Future<Either<Failure, Login>> getUserLogin(LoginParameters parameters)async {
    final result = await baseLoginRemoteDataSource.getLoginUser(parameters);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, ForgetPassword>> getForgetPassword(ForgetPasswordParameters parameters)async {
    final result = await baseLoginRemoteDataSource.getForgetPassword(parameters);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, ResetPassword>> getResetPassword(ResetPasswordParameters parameters)async {
    final result = await baseLoginRemoteDataSource.getResetPassword(parameters);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

}