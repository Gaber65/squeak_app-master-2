import '../../domain/entities/verfication_code.dart';

class VerificationCodeModel extends VerificationCode {
  const VerificationCodeModel({
    required super.success,
    required super.message,
    required super.data,
    required super.statusCode,
  });

  factory VerificationCodeModel.formJson(Map<String, dynamic> json) {
    return VerificationCodeModel(
      success: json['success'],
      message: json['message'],
      data: json['data'],
      statusCode: json['statusCode'],
    );
  }
}
