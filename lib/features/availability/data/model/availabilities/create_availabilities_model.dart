import '../../../domain/entities/availabilities/create_availabilities_entities.dart';

class CreateAvailabilitiesModel extends CreateAvailabilitiesEntities {
  const CreateAvailabilitiesModel({required super.availabilitiesDate});
  factory CreateAvailabilitiesModel.fromJson(Map<String, dynamic> json) {
    return CreateAvailabilitiesModel(
      availabilitiesDate: AvailabilitiesDataModel.fromJson(json['data']),
    );
  }
}

class AvailabilitiesDataModel extends AvailabilitiesDate {
  const AvailabilitiesDataModel({required super.availabilities});

  factory AvailabilitiesDataModel.fromJson(Map<String, dynamic> json) {
    return AvailabilitiesDataModel(
      availabilities: AvailabilitiesModel.fromJson(json['availabilityDto']),
    );
  }
}

class AvailabilitiesModel extends Availabilities {
  const AvailabilitiesModel({
    required super.id,
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    required super.clinicId,
  });
  factory AvailabilitiesModel.fromJson(Map<String, dynamic> json) {
    return AvailabilitiesModel(
      id: json['id'],
      dayOfWeek: json['dayOfWeek'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      clinicId: json['clinicId'],
    );
  }
}
