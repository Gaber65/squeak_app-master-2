import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../../../core/network/dio_helper.dart';
import '../../../../../core/network/end-points.dart';
import '../../../../../core/service/service_locator.dart';
import '../../domain/repository/base_update_profile_repository.dart';
import '../model/update_profile_model.dart';

abstract class BaseUpdateProfileRemoteDataSource {
  Future<UpdateProfileModel> getUpdateProfile(UpdateProfileParameters parameter);
}

class UpdateProfileRemoteDataSource extends BaseUpdateProfileRemoteDataSource {
  final DioHelper dioHelper;

  UpdateProfileRemoteDataSource(this.dioHelper);

  @override
  Future<UpdateProfileModel> getUpdateProfile(
      UpdateProfileParameters parameter) async {
    final data = FormData();
    if (parameter.Imagepath.isNotEmpty) {
      final multipartImage = await MultipartFile.fromFile(parameter.Imagepath);
      data.files.add(
        MapEntry('image', multipartImage),
      );
    }
    data.fields.addAll({
      MapEntry('fullname', parameter.fullName!),
      MapEntry('phone', parameter.phone),
      MapEntry('addresss', parameter.addresss),
      MapEntry('Birthdat', parameter.Birthdate),
      MapEntry('gender', parameter.gender!),
      MapEntry('email', parameter.email!),
    });




    final response = await dioHelper.put(
Authorization:sl<SharedPreferences>().getString('token') ,
      endPoint: updateProfileEndPoint,
      data: data,
    );
    return UpdateProfileModel.fromJson(response);
  }
}
