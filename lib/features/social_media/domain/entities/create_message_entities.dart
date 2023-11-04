import 'package:equatable/equatable.dart';

class CreateMessageEntities extends Equatable {
  CreateMessageData? createMessageData;
  Map<String, List<dynamic>>? errors;
  bool? success;
  String? message;

  CreateMessageEntities({
    this.createMessageData,
    this.errors,
    this.success,
    this.message,
  });

  @override
  List<Object?> get props => [
        createMessageData,
        errors,
        success,
        message,
      ];
}

class CreateMessageData extends Equatable {
  final String fromUserId;
  final dynamic toUserId;
  final String message;
  final String time;
  final String clinicId;
  final dynamic image;
  final dynamic video;
  final dynamic voice;

  const CreateMessageData({
    required this.fromUserId,
    required this.toUserId,
    required this.message,
    required this.time,
    required this.image,
    required this.video,
    required this.voice,
    required this.clinicId,
  });

  @override
  List<Object?> get props => [
        fromUserId,
        toUserId,
        message,
        time,
        image,
        video,
        voice,
        clinicId,
      ];
}
