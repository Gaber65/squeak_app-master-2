import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/entities/register.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/repository/base_register_repository.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/usecase/get_register_user_use_case.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/presentation/controller/cubit/register_state.dart';
import 'package:squeak/main.dart';

import '../../../../register_as_a_doctor/data/model/firebase_register_doctor_model.dart';
import '../../../../register_as_a_doctor/domain/repository/base_register_as_a_doctor.dart';
import '../../../../register_as_a_doctor/domain/usecase/create_user_use_case.dart';
import '../../../../register_as_a_doctor/domain/usecase/sign_up.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this.getRegisterUserUseCase,
    this.createUserUseCase,
    this.signUpUseCase,
  ) : super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  final GetRegisterUserUseCase getRegisterUserUseCase;

  Register? register;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  IconData suffix = Icons.visibility_off_outlined;

  void changeRegisterPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeRegisterPasswordVisibility());
  }

  bool isConPassword = true;
  IconData suffixCon = Icons.visibility_off_outlined;

  void changeRegisterConPasswordVisibility() {
    isConPassword = !isConPassword;
    suffixCon = isConPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ChangeRegisterConPasswordVisibility());
  }

  void getRegisterUser({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String confirmationPassword,
  }) async {
    emit(GetRegisterUserLoadingState());

    final result = await getRegisterUserUseCase(
      RegisterParameters(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
        confirmationPassword: confirmationPassword,
      ),
    );
    result.fold(
      (l) {
        emit(GetRegisterUserErrorState(l.message));
      },
      (r) {
        register = r;
        emit(GetRegisterUserSuccessState(r));
      },
    );
  }

  SignUpUseCase signUpUseCase;

  Future<void> userRegister({
    required String email,
    required String password,
    required String username,
    required String phone,
    required int role,
  }) async {
    emit(LoadingRegisterState());
    try {
      final result = await signUpUseCase(
        SignInParameters(
          email: email,
          password: password,
        ),
      );
      print('Success SignUp cubit ********************************************************');
      createUser(
        fullName: username,
        email: email,
        gender: 1,
        role: role,
        phone: '+2$phone',
        uId: FirebaseAuth.instance.currentUser!.uid,
      );
      emit(SuccessRegisterState());
    } catch (error) {
      print('Error SignUp cubit ********************************************************');
      print(error.toString());
      emit(ErrorRegisterState(error.toString()));
    }
    emit(LoadingRegisterState());
  }

  CreateUserUseCase createUserUseCase;

  Future createUser({
    required String fullName,
    required String email,
    required int gender,
    required int role,
    required String phone,
    required String uId,
  }) async {
    emit(CreateUserLoadingState());

    try {
      final result = await createUserUseCase(
        CreateUserParameters(
          deviceToken: 'getToken',
          birthDate: '',
          uId: uId,
          gender: gender,
          image: '',
          role: role,
          isPhoneVerify: false,
          email: email,
          fullName: fullName,
          phone: phone,
        ),
      );
      print('Success Create User cubit ********************************************************');
      emit(CreateUserSuccessState(uId));
    } catch (error) {
      print(
          'Error CreateUser cubit ********************************************************');
      print(error.toString());
    }
  }
}
