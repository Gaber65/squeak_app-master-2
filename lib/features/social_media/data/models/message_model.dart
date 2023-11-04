import '../../domain/entities/create_message_entities.dart';

class CreateMessageModel extends CreateMessageEntities {
  CreateMessageModel({
    required super.createMessageData,
    required super.errors,
    required super.message,
    required super.success,
  });

  factory CreateMessageModel.fromJson(Map<String, dynamic> json) {
    return CreateMessageModel(
      createMessageData: json['data'] == null
          ? json['data']
          : CreateMessageDataModel.fromJson(json['data']),
      errors: json['errors'] == null
          ? json['errors']
          : Map<String, List<dynamic>>.from(json['errors']),
      message: json['message'],
      success: json['success'],
    );
  }
}

class CreateMessageDataModel extends CreateMessageData {
  const CreateMessageDataModel({
    required super.fromUserId,
    required super.toUserId,
    required super.message,
    required super.time,
    required super.image,
    required super.video,
    required super.voice,
    required super.clinicId,
  });

  factory CreateMessageDataModel.fromJson(Map<String, dynamic> json) {
    return CreateMessageDataModel(
      fromUserId: json['fromUserId'],
      toUserId: json['toUserId'],
      message: json['description'],
      time: json['createdAt'],
      image: json['image'],
      video: json['video'],
      voice: json['voice'],
      clinicId: json['clinicId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'description': message,
      'createdAt': time,
      'image': image,
      'video': video,
      'voice': voice,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': fromUserId,
      'receiverId': toUserId,
      'message': message,
      'time': time,
      'image': image,
      'video': video,
      'voice': voice,
    };
  }
}
