import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/social_media/domain/base_repository/chat_base_repo.dart';
import 'package:squeak/features/social_media/domain/entities/get_massage_entities.dart';
import 'package:squeak/features/social_media/domain/entities/notifications_entities.dart';
import 'package:squeak/features/social_media/domain/use_case/send_notification_use_case.dart';

import '../../../../core/error/exception.dart';
import '../../../authentication/register/register_as_a_doctor/data/model/firebase_register_doctor_model.dart';
import '../../domain/entities/create_message_entities.dart';
import '../data_source/chat_data_source.dart';

class ChatRepo extends ChatBaseRepository {
  final ChatBaseRemoteDataSource chatRemoteDataSource;

  ChatRepo(this.chatRemoteDataSource);


  @override
  Future sendNotification(SendNotificationParameters parameters) async {
    try {
      await chatRemoteDataSource
          .sendPushNotificationToASpecificUser(parameters);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<RegisterFireAsDoctorModel> getUserData() async {
    try {
      final result = await chatRemoteDataSource.getUserProfile();
      return result;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, NotificationsEntities>> getNotification() async {
    final result =
    await chatRemoteDataSource.getNotifications();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, CreateMessageEntities>> createMassage(
      CreateMassageParameter parameters) async {
    final result = await chatRemoteDataSource.sendMessageDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, GetMassageEntities>> getUserMassage(
      GetMassageParameter parameters) async {
    final result = await chatRemoteDataSource.getUserMessageDataSource(
        parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, GetMassageEntities>> getAdminMassage(
      GetMassageParameter parameters) async {
    final result = await chatRemoteDataSource.getAdminMessageDataSource(
        parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, CreateMessageEntities>> createMassageAdmin(
      CreateMassageParameter parameters) async {
    final result = await chatRemoteDataSource.sendAdminDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }
}