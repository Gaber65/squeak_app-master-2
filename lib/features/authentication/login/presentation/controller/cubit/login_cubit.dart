import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/features/layout/cubit/squeak_cubit.dart';

import '../../../domain/entities/forget_password.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/entities/reset_password.dart';
import '../../../domain/repository/base_auth_repository.dart';
import '../../../domain/usecase/get_froget_password_use_case.dart';
import '../../../domain/usecase/get_login_use_case.dart';
import '../../../domain/usecase/get_reset_password_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this.getLoginUseCase,
    this.getForgetPasswordUserCase,
    this.getResetPasswordUseCase,
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
  void getLoginUser(
      {required String email, required String password, context}) async {
    emit(GetLoginUserLoadingState());

    final result = await getLoginUseCase(
      LoginParameters(email: email, password: password),
    );

    result.fold(
      (l) {
        emit(GetLoginUserErrorState(l.message));
      },
      (r) {
        login = r;
        emit(GetLoginUserSuccessState(r));
        SqueakCubit.get(context).getOwnerPits();
        SqueakCubit.get(context).getProfile();
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
  final GetResetPasswordUseCase getResetPasswordUseCase;

  ResetPassword? resetPassword;
  void getResetPassword({
    required String token,
    required String password,
  }) async {
    emit(ResetPasswordLoadingState());

    final result = await getResetPasswordUseCase(
      ResetPasswordParameters(
        token: token,
        password: password,
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
}
