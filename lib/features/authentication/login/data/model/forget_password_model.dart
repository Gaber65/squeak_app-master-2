import '../../domain/entities/forget_password.dart';

class ForgetPasswordModel extends ForgetPassword {
  const ForgetPasswordModel({
    required super.success,
    required super.message,
    required super.data,
    required super.statusCode,
  });

  factory ForgetPasswordModel.formJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      success: json['success'],
      message: json['message'],
      data: json['data'],
      statusCode: json['statusCode'],
    );
  }
}
