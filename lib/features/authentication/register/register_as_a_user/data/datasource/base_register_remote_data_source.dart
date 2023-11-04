import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:squeak/core/error/error_message_model.dart';
import 'package:squeak/core/error/exception.dart';
import 'package:squeak/core/network/dio.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/data/model/register_model.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/repository/base_register_repository.dart';

abstract class BaseRegisterRemoteDataSource {
  Future<RegisterModel> getUserRegister(RegisterParameters parameters);
}

class RegisterRemoteDataSource extends BaseRegisterRemoteDataSource {
  @override
  Future<RegisterModel> getUserRegister(RegisterParameters parameters) async {
    try {
      final result = await DioFinalHelper.postData(
        method: '$version$registerEndPoint',
        data: {
          "fullName": parameters.fullName,
          "email": parameters.email,
          "password": parameters.password,
          "PasswordConfirm": parameters.confirmationPassword,
          "gender": 2,
          "userType": 1,
          "phone": parameters.phone
        },
      );
      return RegisterModel.fromJson(result.data);
    } on DioException catch (error) {
      return RegisterModel.fromJson(error.response!.data);
    }
  }
}
