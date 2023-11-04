import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/dio.dart';
import '../../../../core/network/end-points.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/error/error_message_model.dart';
import '../../domain/repository/base_availabilities_repository.dart';
import '../model/appointments/create_Appointments_model.dart';
import '../model/appointments/delete_appointments_model.dart';
import '../model/appointments/get_appointments_model.dart';
import '../model/appointments/updata_model.dart';
import '../model/availabilities/create_availabilities_model.dart';
import '../model/availabilities/delete_availabilities_model.dart';
import '../model/availabilities/get_availabilities_model.dart';
import '../model/availabilities/updata_model.dart';

abstract class BaseAvailabilitiesRemoteDataSource {
  ///todo availabilities
  Future<CreateAvailabilitiesModel> createAvailabilitiesDataSource(
      CreateAvailabilitiesParameters parameters);
  Future<UpdateModel> updateAvailabilitiesDataSource(
      CreateAvailabilitiesParameters parameters);
  Future<GetAvailabilitiesModel> getAvailabilitiesDataSource(
      GetAvailabilitiesParameters parameters);
  Future<DeleteAvailabilitiesModel> deleteAvailabilitiesDataSource(
      GetAvailabilitiesParameters parameters);

  ///todo appointments
  Future<CreateAppointmentsModel> createAppointmentsDataSource(CreateAppointmentsParameters parameters);
  Future<UpdateModelAppointments> updateAppointmentsDataSource(CreateAppointmentsParameters parameters);
  Future<GetAppointmentsModel> getAppointmentsDataSource();
  Future<GetAppointmentsModel> getAppointmentsDoctorDataSource();
  Future<DeleteAppointmentsModel> deleteAppointmentsDataSource(DeleteAppointmentsParameters parameters);
}

class AvailabilitiesRemoteDataSource
    extends BaseAvailabilitiesRemoteDataSource {
  @override
  Future<CreateAvailabilitiesModel> createAvailabilitiesDataSource(
      CreateAvailabilitiesParameters parameters) async {
    final response = await DioFinalHelper.postData(
        method: '$version$createAvailabilitiesEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "dayOfWeek": parameters.dayOfWeek,
          "startTime": parameters.startTime,
          "endTime": parameters.endTime,
          "clinicId": parameters.clinicId,
        });
    if (response.data['success'] == true) {
      print(response.data.toString()+'=============================== response ============================');
      log(response.toString());
      return CreateAvailabilitiesModel.fromJson(response.data!);
    } else {
      throw ServerException(
        statusErrorMessageModel:
        StatusErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<DeleteAvailabilitiesModel> deleteAvailabilitiesDataSource(
      GetAvailabilitiesParameters parameters) async {
    final response = await DioFinalHelper.deleteData(
      method: '$version${deleteAvailabilitiesEndPoint(parameters.clinicId)}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return DeleteAvailabilitiesModel.fromJson(response.data!);
  }

  @override
  Future<GetAvailabilitiesModel> getAvailabilitiesDataSource(
      GetAvailabilitiesParameters parameters) async {
    final response = await DioFinalHelper.getData(
      method: '$version${getAvailabilitiesEndPoint(parameters.clinicId)}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return GetAvailabilitiesModel.fromJson(response.data!);
  }

  @override
  Future<UpdateModel> updateAvailabilitiesDataSource(
      CreateAvailabilitiesParameters parameters) async {
    final response = await DioFinalHelper.patchData(
        method: '$version${updateAvailabilitiesEndPoint(parameters.availabilitiesId!)}',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "dayOfWeek": parameters.dayOfWeek,
          "startTime": parameters.startTime,
          "endTime": parameters.endTime,
          "clinicId": parameters.clinicId,
        });
    return UpdateModel.fromJson(response.data!);
  }

  @override
  Future<CreateAppointmentsModel> createAppointmentsDataSource(CreateAppointmentsParameters parameters) async {
    try {
      final response = await DioFinalHelper.postData(
        method: '$version$createAppointmentsEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "petId": parameters.petId,
          "doctorId": parameters.doctorId,
          "availabilityId": parameters.availabilityId,
          "visitComment": parameters.visitComment,
          "appointmentDate": parameters.appointmentDate,
          "AppointmentTime": parameters.appointmentTime,
          "status": parameters.status,
        },
      );
      return CreateAppointmentsModel.fromJson(response.data!);
    }  on DioException catch (error) {
      return CreateAppointmentsModel.fromJson(error.response!.data);

    }

  }

  @override
  Future<DeleteAppointmentsModel> deleteAppointmentsDataSource(DeleteAppointmentsParameters parameters) async {
    final response = await DioFinalHelper.deleteData(
      method: '$version${deleteAppointmentsEndPoint(parameters.appointmentsId)}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return DeleteAppointmentsModel.fromJson(response.data!);
  }

  @override
  Future<GetAppointmentsModel> getAppointmentsDataSource() async {
    final response = await DioFinalHelper.getData(
      method: '$version$getAppointmentsEndPoint',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return GetAppointmentsModel.fromJson(response.data!);
  }

  @override
  Future<UpdateModelAppointments> updateAppointmentsDataSource(CreateAppointmentsParameters parameters) async {
    final response = await DioFinalHelper.patchData(
      method: '$version${updateAppointmentsEndPoint(parameters.appointmentsId!)}',
      token: sl<SharedPreferences>().getString('refreshToken'),
      data: {
        "petId": parameters.petId,
        "doctorId": parameters.doctorId,
        "availabilityId": parameters.availabilityId,
        "visitComment": parameters.visitComment,
        "appointmentDate": parameters.appointmentDate,
        "AppointmentTime": parameters.appointmentTime,
        "status": parameters.status,
      },
    );
    return UpdateModelAppointments.fromJson(response.data!);
  }

  @override
  Future<GetAppointmentsModel> getAppointmentsDoctorDataSource() async{
    final response = await DioFinalHelper.getData(
      method: '$version$getAppointmentsDoctorEndPoint',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return GetAppointmentsModel.fromJson(response.data!);
  }
}
