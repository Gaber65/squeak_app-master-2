
import 'package:squeak/features/availability/domain/entities/Appointments/get_Appointments_entities.dart';

import '../../../domain/entities/Appointments/update_appointments_entities.dart';

abstract class AppointmentsState {}

class AppointmentsInitial extends AppointmentsState {}

///todo Create Appointments
class CreateAppointmentsLoading extends AppointmentsState {}
class CreateAppointmentsSuccess extends AppointmentsState {
  CreateAppointmentsEntities createAppointmentsEntities;

  CreateAppointmentsSuccess(this.createAppointmentsEntities);
}
class CreateAppointmentsError extends AppointmentsState {}

///todo Update Appointments
class UpdateAppointmentsLoading extends AppointmentsState {}
class UpdateAppointmentsSuccess extends AppointmentsState {}
class UpdateAppointmentsError extends AppointmentsState {}


///todo Delete Appointments
class DeleteAppointmentsLoading extends AppointmentsState {}
class DeleteAppointmentsSuccess extends AppointmentsState {}
class DeleteAppointmentsError extends AppointmentsState {}



///todo Get Appointments
class GetAppointmentsLoading extends AppointmentsState {}
class GetAppointmentsSuccess extends AppointmentsState {
  GetAppointmentsEntities appointmentsEntities;

  GetAppointmentsSuccess(this.appointmentsEntities);
}
class GetAppointmentsError extends AppointmentsState {}