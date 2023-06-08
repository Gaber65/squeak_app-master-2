

import '../../../domain/entities/verfication_code.dart';

abstract class VerificationCodeState{}

class VerificationInitialCodeState extends VerificationCodeState{}

class GetVerificationLoadingState extends VerificationCodeState{}
class GetVerificationSuccessState extends VerificationCodeState{
  final VerificationCode verificationCode;

  GetVerificationSuccessState(this.verificationCode);
}
class GetVerificationErrorState extends VerificationCodeState{
  final String message;

  GetVerificationErrorState(this.message);
}