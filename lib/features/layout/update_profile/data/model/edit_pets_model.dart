import 'package:squeak/features/layout/update_profile/data/model/find_pet_by_owner_id_model.dart';

import '../../domain/entities/edit_pets_data.dart';

class EditPetModel extends EditPetData {
  EditPetModel({super.status, super.message, super.data});

  EditPetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}
