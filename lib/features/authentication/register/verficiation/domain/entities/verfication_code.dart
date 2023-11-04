import 'package:equatable/equatable.dart';

class VerificationCode extends Equatable {
  final bool success;
  final dynamic data;
  final String message;
  final int statusCode;

  const VerificationCode({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [
        success,
        data,
        message,
        statusCode,
      ];
}
