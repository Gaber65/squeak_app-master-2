
import '../../domain/entities/reset_password.dart';

class ResetPasswordModel extends ResetPassword {
  const ResetPasswordModel({
    required super.status,
    required super.messages,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      status: json['status'],
      messages: json['messages'],
    );
  }
}
