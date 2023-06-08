import 'package:squeak/core/network/dio_helper.dart';
import 'package:squeak/core/network/end-points.dart';

import '../../domain/repository/base_auth_repository.dart';
import '../model/forget_password_model.dart';
import '../model/login_model.dart';
import '../model/reset_password_model.dart';

abstract class BaseLoginRemoteDataSource {
  Future<LoginModel> getLoginUser(LoginParameters parameters);
  Future<ForgetPasswordModel> getForgetPassword(
      ForgetPasswordParameters parameters);
  Future<ResetPasswordModel> getResetPassword(
      ResetPasswordParameters parameters);
}

class LoginRemoteDataSource extends BaseLoginRemoteDataSource {
  final DioHelper dioHelper;

  LoginRemoteDataSource(this.dioHelper);

  @override
  Future<LoginModel> getLoginUser(LoginParameters parameters) async {
    final response = await dioHelper.post(
      endPoint: loginEndPoint,
      data: {
        'email': parameters.email,
        'password': parameters.password,
      },
      Authorization: token,
    );
    return LoginModel.fromJson(response);
  }

  @override
  Future<ForgetPasswordModel> getForgetPassword(
      ForgetPasswordParameters parameters) async {
    final response = await dioHelper.post(
      endPoint: forgetPasswordEndPoint(
        parameters.email,
      ),
    );
    return ForgetPasswordModel.fromJson(response);
  }

  @override
  Future<ResetPasswordModel> getResetPassword(
      ResetPasswordParameters parameters) async {
    final response = await dioHelper.post(
      endPoint: resetPasswordEndPoint,
      data: {
        'token' : parameters.token,
        'password' : parameters.password,
      },
    );
    return ResetPasswordModel.fromJson(response);
  }
}
