part of 'helper_cubit.dart';

abstract class HelperState {}

class HelperInitial extends HelperState {}

class ImageHelperLoading extends HelperState {}

class ImageHelperSuccess extends HelperState {
  HelperModel helperModel;

  ImageHelperSuccess(this.helperModel);
}

class ImageHelperError extends HelperState {}

class GetUserRefreshTokenLoading extends HelperState {}

class GetUserRefreshTokenSuccess extends HelperState {}

class GetUserRefreshTokenError extends HelperState {
  final String error;

  GetUserRefreshTokenError(this.error);
}

class GetRefreshTokenSuccess extends HelperState {}

class GetRefreshTokenLoading extends HelperState {}

class GetRefreshTokenError extends HelperState {
  final String error;

  GetRefreshTokenError(this.error);
}
