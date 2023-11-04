import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';

import '../../../../../core/main_basic/main_basic.dart';
import '../../../../authentication/login/data/model/login_model.dart';

class SpeciesModel extends SpeciesEntities {
  SpeciesModel({
    required super.data,
    required super.statusCode,
    required super.message,
    required super.success,
    required super.errors,
  });

  SpeciesModel.fromJson(
    Map<String, dynamic> json,
  ) {
    success = json['success'];
    errors =
        json['errors'] != null ? null : ErrorModel.fromJson(json['errors']);
    data = List.from(json['data']['speciesDtos'])
        .map((e) => SpeciesDataModel.fromJson(e))
        .toList();
    message = null;
    statusCode = json['statusCode'];
  }
}

class SpeciesDataModel extends SpeciesData {
  const SpeciesDataModel({required super.enType, required super.id});

  factory SpeciesDataModel.fromJson(Map<String, dynamic> json) {
    return SpeciesDataModel(
      id: json['id'],
      enType: isArabic() ? json['arType'] : json['enType'],
    );
  }
}
