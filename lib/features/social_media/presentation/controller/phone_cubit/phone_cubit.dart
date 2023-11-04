import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:squeak/core/network/end-points.dart';

import '../../../../../core/usecase/base_usecase.dart';
import '../../../../authentication/register/register_as_a_doctor/domain/entities/firebase_register_doctor.dart';
import '../../../domain/use_case/get_user.dart';

part 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  PhoneCubit(this.getUserDataUseCase) : super(PhoneInitial());
  static PhoneCubit get(context) => BlocProvider.of(context);

  GetUserDataUseCase getUserDataUseCase;
  RegisterFireAsDoctor? socialDataUser;
  Future getUserData() async {
    emit(GetUserDataLoading());
    try {
      final result = await getUserDataUseCase(const NoParameters());
      print(
          'Success get User Data cubit ********************************************************');
      print(result.uId);
      print(result.email);

      socialDataUser = result;
      print(socialDataUser!.fullName);
      emit(GetUserDataSuccess());
    } catch (error) {
      print(
          'Error get User Data cubit ********************************************************');
      print(error.toString());
      emit(GetUserDataError());
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> verifySendPhoneNumber({
    String? phoneNumber,
    String? smsCode,
  }) async {
    emit(VerifyPhoneDataLoading());

    // set up verification options
    // initiate phone number verification
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(minutes: 2),
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) async {
        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode!,
        );
        emit(VerifyPhoneDataSuccess());

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

}
