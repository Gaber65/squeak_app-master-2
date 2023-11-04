import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/exception.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/data/datasource/base_register_remote_data_source.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/entities/register.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/repository/base_register_repository.dart';

import '../../../register_as_a_doctor/domain/usecase/create_user_use_case.dart';



class RegisterRepository extends BaseRegisterRepository
{
  final BaseRegisterRemoteDataSource baseRegisterRemoteDataSource;

  RegisterRepository(this.baseRegisterRemoteDataSource);
  @override
  Future<Either<Failure, Register>> getUserRegister(RegisterParameters parameters)async {
    final result = await baseRegisterRemoteDataSource.getUserRegister(parameters);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.error.keys.first));
    }
  }


}