
import '../../domain/entities/verfication_code.dart';

class VerificationCodeModel extends VerificationCode {
  const VerificationCodeModel({
    required super.status,
    required super.messages,
  });

  factory VerificationCodeModel.formJson(Map<String, dynamic> json) {
    return VerificationCodeModel(
      status: json['status'],
      messages: json['messages'],
    );
  }
}
