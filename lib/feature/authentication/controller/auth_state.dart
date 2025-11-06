part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

/// todo create user
class CreateUserLoadingState extends AuthState {}
class CreateUserSuccessState extends AuthState {
  String uid;
  CreateUserSuccessState(this.uid);
}
class CreateUserErrorState extends AuthState {}

/// todo create user Using Google
class CreateUserUsingGoogleLoadingState extends AuthState {}
class CreateUserUsingGoogleSuccessState extends AuthState {
  String uid;
  CreateUserUsingGoogleSuccessState(this.uid);
}
class CreateUserUsingGoogleErrorState extends AuthState {}

/// todo create user Using facebook
class CreateUserUsingFacebookLoadingState extends AuthState {}
class CreateUserUsingFacebookSuccessState extends AuthState {
  String uid;
  CreateUserUsingFacebookSuccessState(this.uid);
}
class CreateUserUsingFacebookErrorState extends AuthState {}

/// todo create user Using phone
class CreateUserUsingPhoneLoadingState extends AuthState {}
class CreateUserUsingPhoneSuccessState extends AuthState {
  String uid;
  CreateUserUsingPhoneSuccessState(this.uid);
}
class CreateUserUsingPhoneErrorState extends AuthState {}

/// todo create user Using facebook
class CreateUserUsingEmailLoadingState extends AuthState {}
class CreateUserUsingEmailSuccessState extends AuthState {
  String uid;
  CreateUserUsingEmailSuccessState(this.uid);
}
class CreateUserUsingEmailErrorState extends AuthState {}


/// todo login With verify email
class VerifyEmailLoadingState extends AuthState {}
class VerifyEmailSuccessState extends AuthState {}
class VerifyEmailErrorState extends AuthState {}

/// todo confirm email
class ConfirmEmailLoadingState extends AuthState {}
class ConfirmEmailSuccessState extends AuthState {}
class ConfirmEmailErrorState extends AuthState {}