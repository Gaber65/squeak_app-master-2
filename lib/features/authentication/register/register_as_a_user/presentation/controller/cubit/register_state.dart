import 'package:squeak/features/authentication/register/register_as_a_user/domain/entities/register.dart';

abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class ChangeRegisterPasswordVisibility extends RegisterState {}

class ChangeRegisterConPasswordVisibility extends RegisterState {}

class GetRegisterUserLoadingState extends RegisterState {}

class GetRegisterUserSuccessState extends RegisterState {
  final Register register;

  GetRegisterUserSuccessState(this.register);
}

class GetRegisterUserErrorState extends RegisterState {
  final String error;
  GetRegisterUserErrorState(this.error);
}
