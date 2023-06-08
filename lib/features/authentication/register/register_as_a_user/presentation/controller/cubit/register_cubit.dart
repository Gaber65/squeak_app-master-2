import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/entities/register.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/repository/base_register_repository.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/usecase/get_register_user_use_case.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/presentation/controller/cubit/register_state.dart';



class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this.getRegisterUserUseCase,
  ) : super(InitialRegisterState());

  final GetRegisterUserUseCase getRegisterUserUseCase;

  Register? register;

  static RegisterCubit get(context) => BlocProvider.of(context);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
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
}
