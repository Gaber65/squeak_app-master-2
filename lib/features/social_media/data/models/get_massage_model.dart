import '../../domain/entities/create_message_entities.dart';
import '../../domain/entities/get_massage_entities.dart';
import 'message_model.dart';

class GetMassageModel extends GetMassageEntities {
  GetMassageModel({
    required super.massages,
    required super.errors,
    required super.state,
  });

  factory GetMassageModel.fromJson(Map<String, dynamic> json) {
    return GetMassageModel(
      massages: json['data'] == null
          ? json['data']
          : List.from(json['data']['result'])
              .map((e) => CreateMessageDataModel.fromJson(e))
              .toList(),
      state: json['message'],
      errors: Map<String, List<dynamic>>.from(json['errors']),
    );
  }
}
