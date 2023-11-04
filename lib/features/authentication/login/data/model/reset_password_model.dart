
import '../../domain/entities/reset_password.dart';

class ResetPasswordModel extends ResetPassword {
  const ResetPasswordModel({
    required super.status,
    required super.messages,
    required super.errors,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      status: json['success'],
      messages: json['message'],
      errors: Map<String, List<dynamic>>.from(json['errors']),

    );
  }
}
