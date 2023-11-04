import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/network/end-points.dart';
import '../../../../../../core/service/service_locator.dart';
import '../../../../../../main.dart';
import '../../../../register/register_as_a_doctor/domain/repository/base_register_as_a_doctor.dart';
import '../../../data/model/login_model.dart';
import '../../../domain/entities/forget_password.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/entities/reset_password.dart';
import '../../../domain/repository/base_auth_repository.dart';
import '../../../domain/usecase/get_froget_password_use_case.dart';
import '../../../domain/usecase/get_login_use_case.dart';
import '../../../domain/usecase/get_reset_password_use_case.dart';
import '../../../../register/register_as_a_doctor/domain/usecase/sign_in.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this.getLoginUseCase,
    this.getForgetPasswordUserCase,
    this.getResetPasswordUseCase,
    this.signInUseCase,
  ) : super(LoginInitialState());

  final GetLoginUseCase getLoginUseCase;
  Login? login;

  static LoginCubit get(context) => BlocProvider.of(context);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  IconData suffix = Icons.visibility_off_outlined;

  void changeLoginPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeLoginPasswordVisibility());
  }

//////////////////////////////////////////////////////
  void getLoginUser({
    required String email,
    required String password,
  }) async {
    emit(GetLoginUserLoadingState());
    final result = await getLoginUseCase(
      LoginParameters(
        email: email,
        password: password,
      ),
    );
    result.fold(
      (l) {
        emit(GetLoginUserErrorState(l.message));
      },
      (r) {
        login = r;
        print(r.toString() +
            'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
        emit(GetLoginUserSuccessState(r));
      },
    );
  }

////////////////////////////////////////////
  final GetForgetPasswordUserCase getForgetPasswordUserCase;
  ForgetPassword? forgetPassword;

  void getForgetPassword({
    required String email,
  }) async {
    emit(ForgetPasswordLoadingState());

    final result = await getForgetPasswordUserCase(
      ForgetPasswordParameters(
        email: email,
      ),
    );

    result.fold(
      (l) {
        emit(ForgetPasswordErrorState(l.message));
      },
      (r) {
        forgetPassword = r;
        emit(ForgetPasswordSuccessState(r));
      },
    );
  }

///////////////////////////////////////////////////
  var codeController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  final GetResetPasswordUseCase getResetPasswordUseCase;

  ResetPassword? resetPassword;

  void getResetPassword({
    required String token,
    required String password,
    required String email,
    required String confirmNewPassword,
  }) async {
    emit(ResetPasswordLoadingState());

    final result = await getResetPasswordUseCase(
      ResetPasswordParameters(
        token: token,
        password: password,
        email: email,
        confirmNewPassword: confirmNewPassword,
      ),
    );
    result.fold(
      (l) {
        emit(ResetPasswordErrorState(l.message));
      },
      (r) {
        resetPassword = r;
        emit(ResetPasswordSuccessState(r));
      },
    );
  }

  SignInUseCase signInUseCase;

  Future userLogin({
    required String email,
    required String password,
  }) async {
    emit((LoadingLoginState()));
    try {
      final response = await signInUseCase(SignInParameters(
        email: email,
        password: password,
      ));
      print(response);
      print(
          'Success SignIn cubit ********************************************************');
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'deviceToken': 'getToken',
      });
      sl<SharedPreferences>().setString('uId', FirebaseAuth.instance.currentUser!.uid) ;
      uId = FirebaseAuth.instance.currentUser!.uid;
      emit(SuccessLoginState(FirebaseAuth.instance.currentUser!.uid));
    } catch (error) {
      print(error.toString());
      emit(ErrorLoginState());
    }
  }




  void changeRegisterAsADoctorPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeLoginPasswordVisibility());
  }

  bool isConPassword = true;
  IconData suffixCon = Icons.visibility_off_outlined;

  void changeRegisterAsADoctorConPasswordVisibility() {
    isConPassword = !isConPassword;
    suffixCon = isConPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ChangeLoginPasswordVisibility());
  }
}
