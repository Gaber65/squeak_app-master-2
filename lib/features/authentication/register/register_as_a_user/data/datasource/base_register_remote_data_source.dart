import 'package:squeak/core/network/dio_helper.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/data/model/register_model.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/repository/base_register_repository.dart';


abstract class BaseRegisterRemoteDataSource {
  Future<RegisterModel> getUserRegister(RegisterParameters parameters);
}

class RegisterRemoteDataSource extends BaseRegisterRemoteDataSource {
  final DioHelper dioHelper;

  RegisterRemoteDataSource(this.dioHelper);

  @override
  Future<RegisterModel> getUserRegister(RegisterParameters parameters) async {
    final response = await dioHelper.post(
      endPoint: registerEndPoint,
      data: {
        'email' : parameters.email,
        'fullName' : parameters.fullName,
        'phone' : parameters.phone,
        'password' : parameters.password,
        'confirmationPassword' : parameters.confirmationPassword,
      },
    );
    return RegisterModel.fromJson(response);
  }
}
