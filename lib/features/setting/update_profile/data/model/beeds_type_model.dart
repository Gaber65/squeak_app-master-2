import 'package:squeak/features/authentication/login/data/model/login_model.dart';

import '../../../../../core/main_basic/main_basic.dart';
import '../../domain/entities/beeds_type_data.dart';

class BreedTypeModel extends BreedEntities {
  BreedTypeModel({
    required super.data,
    required super.statusCode,
    required super.message,
    required super.success,
    required super.errors,
  });

  BreedTypeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errors =
        json['errors'] != null ? null : ErrorModel.fromJson(json['errors']);
    data = json['data'] != null
        ? List.from(json['data']['result'])
            .map((e) => BreedDataModel.fromJson(e))
            .toList()
        : null;
    message = null;
    statusCode = json['statusCode'];
  }
}

class BreedDataModel extends BreadData {
  const BreedDataModel({required super.enType, required super.id});

  factory BreedDataModel.fromJson(Map<String, dynamic> json) {
    return BreedDataModel(
      id: json['id'] ?? '',
      enType: isArabic() ? json['arBreed'] : json['enBreed'],
    );
  }
}
