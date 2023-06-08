import 'package:squeak/core/network/dio_helper.dart';
import 'package:squeak/core/network/end-points.dart';

import '../../domain/repository/base_register_as_a_doctor.dart';
import '../model/register_as_a_doctor_model.dart';




abstract class BaseRegisterAsADoctorRemoteDataSource {
  Future<RegisterAsADoctorModel> getRegisterAsADoctor(RegisterAsADoctorParameters parameters);
}

class RegisterAsADoctorRemoteDataSource extends BaseRegisterAsADoctorRemoteDataSource {
  final DioHelper dioHelper;

  RegisterAsADoctorRemoteDataSource(this.dioHelper);

  @override
  Future<RegisterAsADoctorModel> getRegisterAsADoctor(RegisterAsADoctorParameters parameters) async {
    final response = await dioHelper.post(
      endPoint: registerAsADoctorEndPoint,
      data: {
        'email' : parameters.email,
        'fullName' : parameters.fullName,
        'phone' : parameters.phone,
        'password' : parameters.password,
        'confirmationPassword' : parameters.confirmationPassword,
        'role' : parameters.role,
      },
    );
    return RegisterAsADoctorModel.fromJson(response);
  }
}
