
import '../../../domain/entities/Appointments/delete_Appointments_entities.dart';

class DeleteAppointmentsModel extends DeleteAppointmentsEntities{
  const DeleteAppointmentsModel({required super.data});

  factory DeleteAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return DeleteAppointmentsModel(
      data: DeleteDataModel.fromJson(json['data']),
    );
  }
}
class DeleteDataModel extends DeleteData{
  const DeleteDataModel.fromJson(Map json);
}