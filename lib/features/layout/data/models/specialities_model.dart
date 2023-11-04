import '../../../authentication/login/data/model/login_model.dart';
import '../../../authentication/login/domain/entities/login.dart';
import '../../domain/entites/clinic/speciality_entities.dart';

class SpecialitiesModel extends SpecialitiesEntities {
  SpecialitiesModel({
    required super.success,
    required super.errors,
    required super.data,
    required super.message,
    required super.statusCode,
  });
  SpecialitiesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errors:
    json['errors'] != null ? null : ErrorModel.fromJson(json['errors']);
    data = List.from(json['data']['specialityDtos'])
        .map((e) => SpecialitiesDataModel.fromJson(e))
        .toList();
    message = json['message'];
    statusCode = json['statusCode'];
  }
}

class SpecialitiesDataModel extends SpecialitiesData {
  const SpecialitiesDataModel({
    required super.id,
    required super.name,
  });

  factory SpecialitiesDataModel.fromJson(Map<String, dynamic> json) {
    return SpecialitiesDataModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
