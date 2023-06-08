import '../../domain/entities/forget_password.dart';

class ForgetPasswordModel extends ForgetPassword {
  const ForgetPasswordModel({
    required super.status,
    required super.messages,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      status: json['status'],
      messages: json['messages'],
    );
  }
}
