import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/features/authentication/register/verficiation/presentation/controller/cubit/ver_state.dart';

import '../../../domain/entities/verfication_code.dart';
import '../../../domain/repository/base_verification_code_repository.dart';
import '../../../domain/usecase/get_verification_code_use_case.dart';



class VerificationCodeCubit extends Cubit<VerificationCodeState> {
  VerificationCodeCubit(
    this.getVerificationCodeUseCase,
  ) : super(VerificationInitialCodeState());

  final GetVerificationCodeUseCase getVerificationCodeUseCase;
  VerificationCode? verificationCode;

  static VerificationCodeCubit get(context) => BlocProvider.of(context);

  var verificationTokenController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  void getVerificationCode({
    required String verificationToken,
  }) async {
    emit(GetVerificationLoadingState());

    final result = await getVerificationCodeUseCase(
      VerificationParameters(
        verificationToken: verificationToken,
      ),
    );

    result.fold(
      (l) {
        emit(GetVerificationErrorState(l.message));
      },
      (r) {
        verificationCode = r;
        emit(GetVerificationSuccessState(r));
      },
    );
  }
}
