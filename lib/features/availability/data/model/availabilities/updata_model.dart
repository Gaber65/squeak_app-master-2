import '../../../domain/entities/availabilities/update_av.dart';

class UpdateModel extends UpdateAvailabilities {
  UpdateModel({required super.data});
  factory UpdateModel.fromJson(Map<String, dynamic> json) {
    return UpdateModel(
      data: DataModel.fromJson(json['data']),
    );
  }
}

class DataModel extends Data {
  const DataModel({
    required super.id,
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    required super.clinicId,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      dayOfWeek: json['dayOfWeek'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      clinicId: json['clinicId'],
    );
  }
}
