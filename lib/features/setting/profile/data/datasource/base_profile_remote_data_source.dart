import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/dio.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/features/setting/profile/data/model/profile_model.dart';

import '../../../../../core/service/service_locator.dart';
import '../../domain/usecase/post_contactUs_use_case.dart';
import '../model/ContactUs_model.dart';

abstract class BaseProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<ContactUsModel> postContactUsProfile(TicketParameters parameters);
}

class ProfileRemoteDataSource extends BaseProfileRemoteDataSource {
  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await DioFinalHelper.getData(
        method: '$version$getProfileEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
      );
      return ProfileModel.fromJson(response.data);
    } on DioException catch (error) {
      return ProfileModel.fromJson(error.response!.data);
    }
  }

  @override
  Future<ContactUsModel> postContactUsProfile(
      TicketParameters parameters) async {
    final response = await DioFinalHelper.postData(
        method: '$version$contactUsEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "title": parameters.title,
          "phone": parameters.phone,
          "fullName": parameters.fullName,
          "comment": parameters.comment,
          "email": parameters.email,
          "statues": parameters.statues
        });
    return ContactUsModel.fromJson(response.data);
  }
}
