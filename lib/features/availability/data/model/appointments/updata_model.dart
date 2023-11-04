import '../../../domain/entities/appointments/update_appointments.dart';
import '../../../domain/entities/availabilities/update_av.dart';

class UpdateModelAppointments extends UpdateAppointments {
  UpdateModelAppointments({required super.data});
  factory UpdateModelAppointments.fromJson(Map<String, dynamic> json) {
    return UpdateModelAppointments(
      data: DataModel.fromJson(json['data']),
    );
  }
}

class DataModel extends AppointmentsData {
  const DataModel({
    required super.id,
    required super.petId,
    required super.doctorId,
    required super.availabilityId,
    required super.visitComment,
    required super.appointmentDate,
    required super.appointmentTime,
    required super.status,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      petId: json['petId'],
      doctorId: json['doctorId'],
      availabilityId: json['availabilityId'],
      visitComment: json['visitComment'],
      appointmentDate: json['appointmentDate'],
      appointmentTime: json['appointmentTime'],
      status: json['status'],

    );
  }
}
