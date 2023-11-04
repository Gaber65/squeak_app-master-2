import 'package:equatable/equatable.dart';
import 'package:squeak/features/availability/domain/entities/Appointments/update_appointments_entities.dart';

class UpdateAppointments {
  UpdateAppointments({
    required this.data,

  });

  final AppointmentsData data;

}

class AppointmentsData extends Equatable {
  const AppointmentsData({
    required this.id,
    required this.petId,
    required this.doctorId,
    required this.availabilityId,
    required this.visitComment,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,

  });

  final String id;
  final String petId;
  final String doctorId;
  final String availabilityId;
  final String visitComment;
  final String appointmentDate;
  final String appointmentTime;
  final int status;


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
  ];
}
