import 'package:equatable/equatable.dart';

class UpdateAvailabilities {
  UpdateAvailabilities({
    required this.data,

  });

  final Data data;

}

class Data extends Equatable {
  const Data({
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
