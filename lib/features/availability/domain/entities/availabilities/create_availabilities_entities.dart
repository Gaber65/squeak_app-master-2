import 'package:equatable/equatable.dart';

class CreateAvailabilitiesEntities extends Equatable {
  final AvailabilitiesDate availabilitiesDate;

  const CreateAvailabilitiesEntities({
    required this.availabilitiesDate,
  });

  @override
  List<Object> get props => [
        availabilitiesDate,
      ];
}

class AvailabilitiesDate extends Equatable {
  final Availabilities availabilities;

  const AvailabilitiesDate({
    required this.availabilities,
  });

  @override
  List<Object> get props => [
        availabilities,
      ];
}

class Availabilities extends Equatable {
  const Availabilities({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.clinicId,
  });

  final String id;
  final int dayOfWeek;
  final String startTime;
  final String endTime;
  final String clinicId;

  @override
  List<Object> get props => [
        id,
        dayOfWeek,
        startTime,
        endTime,
        clinicId,
      ];
}
