
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:squeak/core/network/end-points.dart';

import '../../../../../../core/network/dio.dart';
import '../../domain/repository/base_register_as_a_doctor.dart';
import '../../domain/usecase/create_user_use_case.dart';
import '../model/firebase_register_doctor_model.dart';
import '../model/register_as_a_doctor_model.dart';

abstract class BaseRegisterAsADoctorRemoteDataSource {
  Future<RegisterAsADoctorModel> getRegisterAsADoctor(RegisterAsADoctorParameters parameters);

  Future signUp(SignInParameters parameters);
  Future signIn(SignInParameters parameters);
  Future createUser(CreateUserParameters parameters);
}

class RegisterAsADoctorRemoteDataSource extends BaseRegisterAsADoctorRemoteDataSource {



  @override
  Future<RegisterAsADoctorModel> getRegisterAsADoctor(
      RegisterAsADoctorParameters parameters) async {
    try {
      final result = await DioFinalHelper.postData(
        method: '$version$registerEndPoint',
        data: {
          "fullName": parameters.fullName,
          "email": parameters.email,
          "password": parameters.password,
          "PasswordConfirm": parameters.confirmationPassword,
          "gender": 2,
          "userType": 2,
          "phone": parameters.phone
        },
      );
      return RegisterAsADoctorModel.fromJson(result.data);
    } on DioException catch (error) {
      return RegisterAsADoctorModel.fromJson(error.response!.data);
    }
  }
  @override
  Future signUp(SignInParameters parameters) async
  {
    try{
      final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: parameters.email,
        password: parameters.password,
      );
      print('data source success******************************************************');
      print(response);
      uId = FirebaseAuth.instance.currentUser!.uid;
      print(uId);

    }catch(e)
    {
      print('data source Register Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr   *********************************************');
      rethrow;
    }
  }


  @override
  Future createUser(CreateUserParameters parameters) async
  {
    try{
      RegisterFireAsDoctorModel userDataModel =  RegisterFireAsDoctorModel(
        uId: FirebaseAuth.instance.currentUser!.uid,
        fullName: parameters.fullName,
        email: parameters.email,
        birthDate: '',
        gender: parameters.gender,
        image: parameters.image,
        role: parameters.role,
        isPhoneVerify: parameters.isPhoneVerify,
        deviceToken: parameters.deviceToken,
        phone: parameters.phone,
      );
      print('Uid //////////////////////////////////////// ****************************************');

      print(uId);
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(userDataModel.toMap());
    }
    catch(error)
    {
      rethrow;
    }
  }

  @override
  Future signIn(SignInParameters parameters)async
  {
    try{
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: parameters.email,
        password: parameters.password,
      );
      print('data source success******************************************************');
      print(response);
      uId = FirebaseAuth.instance.currentUser!.uid;
      print(uId);

    }catch(e)
    {
      print('data source Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr   *********************************************');
      rethrow;
    }
  }


}
