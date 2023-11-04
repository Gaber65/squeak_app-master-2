import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/features/authentication/register/register_as_a_doctor/presentation/controller/cubit/register_as_a_doctor_state.dart';
import '../../../../../../../main.dart';
import '../../../data/model/firebase_register_doctor_model.dart';
import '../../../domain/entities/register_as_a_doctor.dart';
import '../../../domain/repository/base_register_as_a_doctor.dart';
import '../../../domain/usecase/get_register_as_a_doctor_use_case.dart';
import '../../../domain/usecase/create_user_use_case.dart';
import '../../../domain/usecase/sign_up.dart';

class RegisterAsADoctorCubit extends Cubit<RegisterAsADoctorState> {
  RegisterAsADoctorCubit(
    this.getRegisterAsADoctorUseCase,
    this.createUserUseCase,
      this.signUpUseCase
  ) : super(RegisterInitialAsADoctorState());

  final GetRegisterAsADoctorUseCase getRegisterAsADoctorUseCase;

  RegisterAsADoctor? registerAsADoctor;

  static RegisterAsADoctorCubit get(context) => BlocProvider.of(context);

  var nameController = TextEditingController();
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
      final result = await signUpUseCase(SignInParameters(email: email, password: password));
      print(
          'Success SignUp cubit ********************************************************');
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
      print(
          'Error SignUp cubit ********************************************************');
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
      print(
          'Success Create User cubit ********************************************************');
      emit(CreateUserSuccessState(uId));
    } catch (error) {
      print(
          'Error CreateUser cubit ********************************************************');
      print(error.toString());
    }
  }

}
