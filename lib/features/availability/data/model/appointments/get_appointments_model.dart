import '../../../domain/entities/Appointments/get_Appointments_entities.dart';
import 'create_Appointments_model.dart';

class GetAppointmentsModel extends GetAppointmentsEntities {
  const GetAppointmentsModel({required super.appointmentsDate});
  factory GetAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return GetAppointmentsModel(
      appointmentsDate: GetAppointmentsDateModel.fromJson(json['data']),
    );
  }
}

class GetAppointmentsDateModel extends GetAppointmentsDate {
  const GetAppointmentsDateModel({
    required super.count,
    required super.appointments,
  });

  factory GetAppointmentsDateModel.fromJson(Map<String, dynamic> json) {
    return GetAppointmentsDateModel(
      appointments: List.from(json['appointments']).map((e)=>AppointmentsModel.fromJson(e)).toList(),
      count: json['count'],
    );
  }
}

