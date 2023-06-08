import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/features/authentication/register/register_as_a_doctor/presentation/controller/cubit/register_as_a_doctor_state.dart';
import '../../../domain/entities/register_as_a_doctor.dart';
import '../../../domain/repository/base_register_as_a_doctor.dart';
import '../../../domain/usecase/get_register_as_a_doctor_use_case.dart';

class RegisterAsADoctorCubit extends Cubit<RegisterAsADoctorState> {
  RegisterAsADoctorCubit(
    this.getRegisterAsADoctorUseCase,
  ) : super(RegisterInitialAsADoctorState());

  final GetRegisterAsADoctorUseCase getRegisterAsADoctorUseCase;

  RegisterAsADoctor? registerAsADoctor;

  static RegisterAsADoctorCubit get(context) => BlocProvider.of(context);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  IconData suffix = Icons.visibility_off_outlined;

  void changeRegisterAsADoctorPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeRegisterAsADoctorPasswordVisibility());
  }

  bool isConPassword = true;
  IconData suffixCon = Icons.visibility_off_outlined;

  void changeRegisterAsADoctorConPasswordVisibility() {
    isConPassword = !isConPassword;
    suffixCon = isConPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ChangeRegisterAsADoctorConPasswordVisibility());
  }

  void getRegisterAsADoctor({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String confirmationPassword,
  }) async {
    emit(GetRegisterAsADoctorLoadingState());

    final result = await getRegisterAsADoctorUseCase(
      RegisterAsADoctorParameters(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
        confirmationPassword: confirmationPassword,
        role: 2,
      ),
    );

    result.fold(
      (l) {
        emit(GetRegisterAsADoctorErrorState(l.message));
      },
      (r) {
        registerAsADoctor = r;
        emit(GetRegisterAsADoctorSuccessState(r));
      },
    );
  }
}
