import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../entities/Appointments/update_appointments_entities.dart';
import '../entities/Appointments/delete_Appointments_entities.dart';
import '../entities/Appointments/get_Appointments_entities.dart';
import '../entities/appointments/update_appointments.dart';
import '../entities/availabilities/create_availabilities_entities.dart';
import '../entities/availabilities/delete_availabilities_entities.dart';
import '../entities/availabilities/get_availabilities_entities.dart';
import '../entities/availabilities/update_av.dart';

abstract class BaseAvailabilitiesRepository {
  ///todo availabilities
  Future<Either<Failure, CreateAvailabilitiesEntities>> createAvailabilities(CreateAvailabilitiesParameters parameters);
  Future<Either<Failure, UpdateAvailabilities>> updateAvailabilities(CreateAvailabilitiesParameters parameters);
  Future<Either<Failure, GetAvailabilitiesEntities>> getAvailabilities(GetAvailabilitiesParameters parameters);
  Future<Either<Failure, DeleteAvailabilitiesEntities>> deleteAvailabilities(GetAvailabilitiesParameters parameters);


  ///todo appointments
  Future<Either<Failure, CreateAppointmentsEntities>> createAppointments(CreateAppointmentsParameters parameters);
  Future<Either<Failure, UpdateAppointments>> updateAppointments(CreateAppointmentsParameters parameters);
  Future<Either<Failure, GetAppointmentsEntities>> getAppointments();
  Future<Either<Failure, GetAppointmentsEntities>> getDoctorAppointments();
  Future<Either<Failure, DeleteAppointmentsEntities>> deleteAppointments(DeleteAppointmentsParameters parameters);


}

class CreateAvailabilitiesParameters extends Equatable {
  final int dayOfWeek;
  final String startTime;
  final String endTime;
  final String clinicId;
  final String? availabilitiesId;

  const CreateAvailabilitiesParameters({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.clinicId,
    this.availabilitiesId,
  });

  @override
  List<Object?> get props =>
      [
        dayOfWeek,
        startTime,
        endTime,
        clinicId,
        availabilitiesId,
      ];
}

class GetAvailabilitiesParameters extends Equatable {
  final String clinicId;

  const GetAvailabilitiesParameters({
    required this.clinicId,
  });

  @override
  List<Object?> get props =>
      [
        clinicId,
      ];
}

class CreateAppointmentsParameters extends Equatable {
  const CreateAppointmentsParameters({
    required this.petId,
    required this.doctorId,
    required this.availabilityId,
    required this.visitComment,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    this.appointmentsId
  });

  final String petId;
  final String doctorId;
  final String availabilityId;
  final String? appointmentsId;
  final String visitComment;
  final String appointmentDate;
  final String appointmentTime;
  final int status;

  @override
  List<Object?> get props =>
      [
        petId,
        doctorId,
        availabilityId,
        appointmentsId,
        visitComment,
        appointmentDate,
        appointmentTime,
        status,
      ];
}

class DeleteAppointmentsParameters extends Equatable {
  final String appointmentsId;

  const DeleteAppointmentsParameters({
    required this.appointmentsId,
  });

  @override
  List<Object?> get props =>
      [
        appointmentsId,
      ];
}
