import 'package:equatable/equatable.dart';

class StatusErrorMessageModel extends Equatable {
  final Map<String, List<dynamic>> error;
  final String message;
  final int code;

  const StatusErrorMessageModel({
    required this.error,
    required this.message,
    required this.code,
  });

  factory StatusErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return StatusErrorMessageModel(
      error: Map<String, List<dynamic>>.from(json['errors']),
      message: json['message'],
      code: json['statusCode'],
    );
  }
  @override
  List<Object?> get props => [
        error,
        message,
        code,
      ];
}
