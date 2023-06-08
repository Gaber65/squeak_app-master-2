import 'package:squeak/core/network/dio_helper.dart';
import 'package:squeak/core/network/end-points.dart';

import '../../domain/repository/base_verification_code_repository.dart';
import '../model/verification_code_model.dart';


abstract class BaseVerificationCodeRemoteUseCase {
  Future<VerificationCodeModel> getVerificationCode(
      VerificationParameters parameters);
}

class VerificationCodeRemoteUseCase extends BaseVerificationCodeRemoteUseCase {
  final DioHelper dioHelper;

  VerificationCodeRemoteUseCase(this.dioHelper);

  @override
  Future<VerificationCodeModel> getVerificationCode(
      VerificationParameters parameters) async {
    final response = await dioHelper.post(
      endPoint: verificationCodeEndPoint(
        parameters.verificationToken,
      ),
    );
    return VerificationCodeModel.formJson(response);
  }
}
