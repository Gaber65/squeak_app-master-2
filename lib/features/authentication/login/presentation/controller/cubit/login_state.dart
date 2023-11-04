

import '../../../domain/entities/forget_password.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/entities/reset_password.dart';

abstract class LoginState{}

class LoginInitialState extends LoginState{}

class ChangeLoginPasswordVisibility extends LoginState{}


class GetLoginUserLoadingState extends LoginState{}
class GetLoginUserSuccessState extends LoginState{
  final Login login;

  GetLoginUserSuccessState(this.login);
}
class GetLoginUserErrorState extends LoginState{

  final String error;
  GetLoginUserErrorState(this.error);
}


/////////////////////////////////////////////////////////////
class ForgetPasswordInitialState extends LoginState{}

class ForgetPasswordLoadingState extends LoginState{}
class ForgetPasswordSuccessState extends LoginState{
  final ForgetPassword forgetPassword;

  ForgetPasswordSuccessState(this.forgetPassword);
}
class ForgetPasswordErrorState extends LoginState{
  final String error;

  ForgetPasswordErrorState(this.error);
}

////////////////////////////////////////////////////////////
class ResetPasswordLoadingState extends LoginState{}
class ResetPasswordSuccessState extends LoginState{
  final ResetPassword resetPassword;

  ResetPasswordSuccessState(this.resetPassword);
}
class ResetPasswordErrorState extends LoginState{
  final String error;

  ResetPasswordErrorState(this.error);
}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final String uId ;
  SuccessLoginState(this.uId);
}

class ErrorLoginState extends LoginState {}
