import 'package:dartz/dartz.dart';

import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/availability/domain/entities/Appointments/update_appointments_entities.dart';
import 'package:squeak/features/availability/domain/entities/Appointments/delete_Appointments_entities.dart';
import 'package:squeak/features/availability/domain/entities/Appointments/get_Appointments_entities.dart';

import 'package:squeak/features/availability/domain/entities/availabilities/create_availabilities_entities.dart';

import 'package:squeak/features/availability/domain/entities/availabilities/delete_availabilities_entities.dart';

import 'package:squeak/features/availability/domain/entities/availabilities/get_availabilities_entities.dart';

import '../../../../core/error/exception.dart';
import '../../domain/entities/appointments/update_appointments.dart';
import '../../domain/entities/availabilities/update_av.dart';
import '../../domain/repository/base_availabilities_repository.dart';
import '../data_source/availabilities_data_source.dart';

class AvailabilitiesRepository extends BaseAvailabilitiesRepository {
  final BaseAvailabilitiesRemoteDataSource baseAvailabilitiesRemoteDataSource;

  AvailabilitiesRepository(this.baseAvailabilitiesRemoteDataSource);

  @override
  Future<Either<Failure, CreateAvailabilitiesEntities>> createAvailabilities(CreateAvailabilitiesParameters parameters)async {
    final result =
    await baseAvailabilitiesRemoteDataSource.createAvailabilitiesDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, DeleteAvailabilitiesEntities>> deleteAvailabilities(GetAvailabilitiesParameters parameters) async{
    final result =
        await baseAvailabilitiesRemoteDataSource.deleteAvailabilitiesDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, GetAvailabilitiesEntities>> getAvailabilities(GetAvailabilitiesParameters parameters) async{
    final result =
    await baseAvailabilitiesRemoteDataSource.getAvailabilitiesDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, UpdateAvailabilities>> updateAvailabilities(CreateAvailabilitiesParameters parameters) async{
    final result = await baseAvailabilitiesRemoteDataSource.updateAvailabilitiesDataSource(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, CreateAppointmentsEntities>> createAppointments(CreateAppointmentsParameters parameters)async {
    final result = await baseAvailabilitiesRemoteDataSource.createAppointmentsDataSource(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, DeleteAppointmentsEntities>> deleteAppointments(DeleteAppointmentsParameters parameters)async {
    final result = await baseAvailabilitiesRemoteDataSource.deleteAppointmentsDataSource(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, GetAppointmentsEntities>> getAppointments()async {
    final result = await baseAvailabilitiesRemoteDataSource.getAppointmentsDataSource();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, UpdateAppointments>> updateAppointments(CreateAppointmentsParameters parameters)async {
    final result = await baseAvailabilitiesRemoteDataSource.updateAppointmentsDataSource(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, GetAppointmentsEntities>> getDoctorAppointments() async{
    final result = await baseAvailabilitiesRemoteDataSource.getAppointmentsDoctorDataSource();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }
}
