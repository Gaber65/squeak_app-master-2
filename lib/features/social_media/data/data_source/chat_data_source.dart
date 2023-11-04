import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/dio.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/end-points.dart';
import '../../../../core/service/service_locator.dart';
import '../../../authentication/register/register_as_a_doctor/data/model/firebase_register_doctor_model.dart';
import '../../domain/base_repository/chat_base_repo.dart';
import '../../domain/use_case/send_message_use_case.dart';
import '../../domain/use_case/send_notification_use_case.dart';
import '../models/get_massage_model.dart';
import '../models/message_model.dart';
import 'package:http/http.dart' as http;

import '../models/notifications_model.dart';

abstract class ChatBaseRemoteDataSource {
  Future<CreateMessageModel> sendMessageDataSource(
      CreateMassageParameter parameters);
  Future<CreateMessageModel> sendAdminDataSource(
      CreateMassageParameter parameters);

  Future<GetMassageModel> getAdminMessageDataSource(
      GetMassageParameter parameters);
  Future<GetMassageModel> getUserMessageDataSource(
      GetMassageParameter parameters);

  Future sendPushNotificationToASpecificUser(
      SendNotificationParameters parameters);

  Future<RegisterFireAsDoctorModel> getUserProfile();

  Future<NotificationsModel> getNotifications();
}

class ChatRemoteDataSource extends ChatBaseRemoteDataSource {
  @override
  Future sendPushNotificationToASpecificUser(
      SendNotificationParameters parameters) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': messageKey
      };
      var request = http.Request('POST', Uri.parse(baseUrlMessageKey));
      request.body = json.encode({
        "to": parameters.deviceToken,
        "notification": {
          "title": parameters.title,
          "body": parameters.body,
          "sound": "default"
        },
        "android": {
          "priorite": "HIGH",
          "notification": {
            "notification_priorite": "PRIORITE_MAX",
            "sound": "default",
            "default_sound": "true",
            "default_vibrate_timings": "true",
            "default_ligth_setting": "true"
          }
        },
        "data": {
          "type": "order",
          "id": "87",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<RegisterFireAsDoctorModel> getUserProfile() async {
    try {
      final response = FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        return RegisterFireAsDoctorModel.fromJson(value.data()!);
      });
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<NotificationsModel> getNotifications() async {
    final result = await DioFinalHelper.getData(
      method: '$version/notifications',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return NotificationsModel.fromJson(result.data);
  }

  @override
  Future<CreateMessageModel> sendMessageDataSource(
    CreateMassageParameter parameters,
  ) async {
    try {
      final response = await DioFinalHelper.postData(
        method: '$version$sendMassageEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "description": parameters.description,
          "image": parameters.image,
          "video": parameters.video,
          "audio": parameters.audio,
          "clinicId": parameters.clinicId,
        },
      );
      print(response.data);
      return CreateMessageModel.fromJson(response.data);
    } on DioException catch (error) {
      return CreateMessageModel.fromJson(error.response!.data);
    }
  }

  @override
  Future<CreateMessageModel> sendAdminDataSource(
      CreateMassageParameter parameters) async {
    try {
      final response = await DioFinalHelper.postData(
        method: '$version$sendMassageEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "description": parameters.description,
          "image": parameters.image,
          "video": parameters.video,
          "audio": parameters.audio,
          "clinicId": parameters.clinicId,
          "toUserId": parameters.toUserId,
        },
      );
      print(response.data);
      return CreateMessageModel.fromJson(response.data);
    } on DioException catch (error) {
      return CreateMessageModel.fromJson(error.response!.data);
    }
  }

  @override
  Future<GetMassageModel> getUserMessageDataSource(
      GetMassageParameter parameters) async {
    try {
      final result = await DioFinalHelper.getData(
        method: '$version${getMassageUserEndPoint(
          parameters.clinicId,
          parameters.pageNumber,
        )}',
        token: sl<SharedPreferences>().getString('refreshToken'),
      );
      return GetMassageModel.fromJson(result.data);
    } on DioException catch (error) {
      return GetMassageModel.fromJson(error.response!.data);
    }
  }

  @override
  Future<GetMassageModel> getAdminMessageDataSource(
      GetMassageParameter parameters) async {
    try {
      final result = await DioFinalHelper.getData(
        method: '$version${getMassageAdminEndPoint(
          clinicId: parameters.clinicId,
          userId: parameters.userId,
          pageNumber: parameters.pageNumber,
        )}',
        token: sl<SharedPreferences>().getString('refreshToken'),
      );
      return GetMassageModel.fromJson(result.data);
    } on DioException catch (error) {
      return GetMassageModel.fromJson(error.response!.data);
    }
  }
}
