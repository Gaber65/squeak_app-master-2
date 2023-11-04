import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/dio.dart';
import 'package:squeak/core/network/end-points.dart';

import '../../../../../../core/service/service_locator.dart';
import '../../domain/repository/base_verification_code_repository.dart';
import '../model/verification_code_model.dart';


abstract class BaseVerificationCodeRemoteUseCase {
  Future<VerificationCodeModel> getVerificationCode(VerificationParameters parameters);
}

class VerificationCodeRemoteUseCase extends BaseVerificationCodeRemoteUseCase {


  @override
  Future<VerificationCodeModel> getVerificationCode(
      VerificationParameters parameters) async {
    final response = await DioFinalHelper.postData(
      method: '$version$verificationCodeEndPoint',
      token: sl<SharedPreferences>().getString('refreshToken'),
      data: {
        "tokenCode": parameters.verificationToken,
        "email": parameters.email,
      },
    );
    return VerificationCodeModel.formJson(response.data);
  }
}
