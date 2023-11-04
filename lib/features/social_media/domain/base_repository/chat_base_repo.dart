import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../authentication/register/register_as_a_doctor/domain/entities/firebase_register_doctor.dart';
import '../entities/create_message_entities.dart';
import '../entities/get_massage_entities.dart';
import '../entities/notifications_entities.dart';
import '../use_case/send_message_use_case.dart';
import '../use_case/send_notification_use_case.dart';

abstract class ChatBaseRepository {
  Future<Either<Failure, CreateMessageEntities>> createMassage(
      CreateMassageParameter parameters);
  Future<Either<Failure, CreateMessageEntities>> createMassageAdmin(
      CreateMassageParameter parameters);
  Future<Either<Failure, GetMassageEntities>> getAdminMassage(
      GetMassageParameter parameters);
  Future<Either<Failure, GetMassageEntities>> getUserMassage(
      GetMassageParameter parameters);

  Future sendNotification(SendNotificationParameters parameters);

  Future<Either<Failure, NotificationsEntities>> getNotification();

  Future<RegisterFireAsDoctor> getUserData();
}

class CreateMassageParameter extends Equatable {
  final String description;
  final String image;
  final String video;
  final String audio;
  final String clinicId;
  String? toUserId;

   CreateMassageParameter({
    required this.description,
    required this.image,
    required this.video,
    required this.audio,
    this.toUserId,
    required this.clinicId,
  });

  @override
  List<Object?> get props => [
        description,
        image,
        video,
        audio,
        toUserId,
        clinicId,
      ];
}

class GetMassageParameter extends Equatable {
  final String userId;
  final String clinicId;
  final int pageNumber;

  const GetMassageParameter({
    required this.userId,
    required this.clinicId,
    required this.pageNumber,
  });

  @override
  List<Object?> get props => [
        userId,
        clinicId,
      ];
}
