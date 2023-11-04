import 'package:equatable/equatable.dart';

class CreateAppointmentsEntities extends Equatable {
  final AppointmentsDate? appointmentsDate;
  final Map<String, List<dynamic>> errors;
  final bool status;

  const CreateAppointmentsEntities({
    required this.appointmentsDate,
    required this.errors,
    required this.status,
  });

  @override
  List<Object?> get props => [
        appointmentsDate,
        errors,
        status,
      ];
}

class AppointmentsDate extends Equatable {
  final Appointments? appointments;

  const AppointmentsDate({
    required this.appointments,
  });

  @override
  List<Object?> get props => [
        appointments,
      ];
}

class Appointments extends Equatable {
  const Appointments({
    required this.id,
    required this.petId,
    required this.doctorId,
    required this.availabilityId,
    required this.visitComment,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    required this.pet,
    required this.doctor,
    required this.availability,
  });

  final String id;
  final String petId;
  final String doctorId;
  final String availabilityId;
  final String visitComment;
  final String appointmentDate;
  final String appointmentTime;
  final int status;
  final PetAppointments? pet;
  final DoctorAppointments? doctor;
  final AvailabilityAppointments? availability;

  @override
  List<Object?> get props => [
        id,
        petId,
        doctorId,
        availabilityId,
        visitComment,
        appointmentDate,
        appointmentTime,
        status,
        pet,
        doctor,
        availability,
      ];
}

class PetAppointments extends Equatable {
  const PetAppointments({
    required this.petName,
    required this.gender,
    required this.imageName,
    required this.birthdate,
  });

  final String petName;
  final int gender;
  final String imageName;
  final String birthdate;

  @override
  List<Object> get props => [
        petName,
        gender,
        imageName,
        birthdate,
      ];
}

class DoctorAppointments extends Equatable {
  const DoctorAppointments({
    required this.fullName,
    required this.address,
    required this.imageName,
    required this.image,
  });

  final dynamic fullName;
  final dynamic address;
  final dynamic imageName;
  final dynamic image;

  @override
  List<Object?> get props => [
        fullName,
        address,
        imageName,
        image,
      ];
}

class AvailabilityAppointments extends Equatable {
  const AvailabilityAppointments({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  final int dayOfWeek;
  final dynamic startTime;
  final dynamic endTime;

  @override
  List<Object?> get props => [
        dayOfWeek,
        startTime,
        endTime,
      ];
}
