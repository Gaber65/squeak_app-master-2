part of 'phone_cubit.dart';

@immutable
abstract class PhoneState {}

class PhoneInitial extends PhoneState {}

class GetUserDataLoading extends PhoneState {}
class GetUserDataSuccess extends PhoneState {}
class GetUserDataError extends PhoneState {}



class VerifyPhoneDataLoading extends PhoneState {}
class VerifyPhoneDataSuccess extends PhoneState {}
class VerifyPhoneDataError extends PhoneState {}
