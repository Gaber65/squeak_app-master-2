import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/dio.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/error/error_message_model.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/service/service_locator.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../model/forget_password_model.dart';
import '../model/login_model.dart';
import '../model/reset_password_model.dart';
import 'package:http/http.dart' as http;

abstract class BaseLoginRemoteDataSource {
  Future<LoginModel> getLoginUser(LoginParameters parameters);
  Future<ForgetPasswordModel> getForgetPassword(
      ForgetPasswordParameters parameters);
  Future<ResetPasswordModel> getResetPassword(
      ResetPasswordParameters parameters);
}

class LoginRemoteDataSource extends BaseLoginRemoteDataSource {
  @override
  Future<LoginModel> getLoginUser(LoginParameters parameters) async {
    try {
      final result = await DioFinalHelper.postData(
        method: '$version$loginEndPoint',
        data: {
          "emailOrUsername": parameters.email,
          "Password": parameters.password
        },
      );
      return LoginModel.fromJson(result.data);
    } on DioException catch (error) {
      return LoginModel.fromJson(error.response!.data);
    }
  }

  @override
  Future<ForgetPasswordModel> getForgetPassword(
      ForgetPasswordParameters parameters) async {
    try {
      final result = await DioFinalHelper.postData(
        method: '$version$forgetPasswordEndPoint',
        data: {
          "email": parameters.email,
        },
      );
      return ForgetPasswordModel.formJson(result.data);
    } on DioException catch (error) {
      return ForgetPasswordModel.formJson(error.response!.data);
    }
  }

  @override
  Future<ResetPasswordModel> getResetPassword(
      ResetPasswordParameters parameters) async {
    try {
      final response = await DioFinalHelper.postData(
        method: '$version$resetPasswordEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "email": parameters.email,
          "tokenCode": parameters.token,
          "newPassword": parameters.password,
          "confirmNewPassword": parameters.confirmNewPassword,
        },
      );
      return ResetPasswordModel.fromJson(response.data);
    } on DioException catch (error) {
      return ResetPasswordModel.fromJson(error.response!.data);
    }
  }
}
