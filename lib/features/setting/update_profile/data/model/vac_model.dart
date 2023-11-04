import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';

import '../../../../authentication/login/data/model/login_model.dart';
import '../../domain/entities/vaccination_entities.dart';

class VacModel extends VacEntities {
  VacModel({
    required super.data,
    required super.statusCode,
    required super.message,
    required super.success,
    required super.errors,
  });

  VacModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    errors= json['errors'] != null ? null : ErrorModel.fromJson(json['errors']);
    data = List.from(json['data']['result']).map((e)=>VacDataModel.fromJson(e)).toList() ;
    message = null;
    statusCode = json['statusCode'];
  }

}

class VacDataModel extends VacEntitiesData {
  const VacDataModel({required super.vaccinationName, required super.id});

  factory VacDataModel.fromJson(Map<String, dynamic> json) {
    return VacDataModel(
      id: json['id'],
      vaccinationName: json['vaccinationName'],
    );
  }
}
