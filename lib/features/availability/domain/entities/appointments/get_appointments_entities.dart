import 'package:equatable/equatable.dart';
import 'update_appointments_entities.dart';


class GetAppointmentsEntities extends Equatable {
  final GetAppointmentsDate appointmentsDate;

  const GetAppointmentsEntities({
    required this.appointmentsDate,
  });

  @override
  List<Object> get props => [
    appointmentsDate,
  ];
}

class GetAppointmentsDate extends Equatable {
  const GetAppointmentsDate({
    required this.count,
    required this.appointments,
  });

  final int count;
  final List<Appointments> appointments;

  @override
  List<Object> get props => [
    count,
    appointments,
  ];
}
