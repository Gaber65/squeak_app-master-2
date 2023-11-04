import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/exception.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/authentication/register/register_as_a_doctor/domain/usecase/create_user_use_case.dart';

import '../../domain/entities/register_as_a_doctor.dart';
import '../../domain/repository/base_register_as_a_doctor.dart';
import '../datasource/base_register_as_a_doctor_remote_data_source.dart';




class RegisterAsADoctorRepository extends BaseRegisterAsADoctorRepository
{
  final BaseRegisterAsADoctorRemoteDataSource baseRegisterAsADoctorRemoteDataSource;

  RegisterAsADoctorRepository(this.baseRegisterAsADoctorRemoteDataSource);
  @override
  Future<Either<Failure, RegisterAsADoctor>> getRegisterAsADoctor(RegisterAsADoctorParameters parameters)async {
    final result = await baseRegisterAsADoctorRemoteDataSource.getRegisterAsADoctor(parameters);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }



  @override
  Future createUser(CreateUserParameters createUserParameters) async{
    final result = await baseRegisterAsADoctorRemoteDataSource.createUser(createUserParameters);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future signIn(SignInParameters signInParameters)async {
    final result = await baseRegisterAsADoctorRemoteDataSource.signIn(signInParameters);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future signUp(SignInParameters signUpParameters) async{
    final result = await baseRegisterAsADoctorRemoteDataSource.signUp(signUpParameters);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

}