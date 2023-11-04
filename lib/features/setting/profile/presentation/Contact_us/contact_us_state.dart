part of 'contact_us_cubit.dart';

abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class ContactUsSendLoading extends ContactUsState {}
class ContactUsSendSuccess extends ContactUsState {}
class ContactUsSendError extends ContactUsState {}
