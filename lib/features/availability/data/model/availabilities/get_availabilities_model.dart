import '../../../domain/entities/availabilities/get_availabilities_entities.dart';
import 'create_availabilities_model.dart';

class GetAvailabilitiesModel extends GetAvailabilitiesEntities {
  const GetAvailabilitiesModel({required super.availabilitiesDate});
  factory GetAvailabilitiesModel.fromJson(Map<String, dynamic> json) {
    return GetAvailabilitiesModel(
      availabilitiesDate: GetAvailabilitiesDateModel.fromJson(json['data']),
    );
  }
}

class GetAvailabilitiesDateModel extends GetAvailabilitiesDate {
  const GetAvailabilitiesDateModel({
    required super.count,
    required super.availabilities,
  });

  factory GetAvailabilitiesDateModel.fromJson(Map<String, dynamic> json) {
    return GetAvailabilitiesDateModel(
      availabilities: List.from(json['availabilities']).map((e)=>AvailabilitiesModel.fromJson(e)).toList(),
      count: json['count'],
    );
  }
}

