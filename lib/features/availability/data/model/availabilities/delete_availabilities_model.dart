
import '../../../domain/entities/availabilities/delete_availabilities_entities.dart';

class DeleteAvailabilitiesModel extends DeleteAvailabilitiesEntities{
  const DeleteAvailabilitiesModel({required super.data});

  factory DeleteAvailabilitiesModel.fromJson(Map<String, dynamic> json) {
    return DeleteAvailabilitiesModel(
      data: DeleteDataModel.fromJson(json['data']),
    );
  }
}
class DeleteDataModel extends DeleteData{
  const DeleteDataModel.fromJson(Map json);
}