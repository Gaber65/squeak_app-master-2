import 'package:equatable/equatable.dart';

class ResetPassword extends Equatable {
  final bool status;
  final String messages;
  final Map<String, List<dynamic>>  errors;


  const ResetPassword({
    required this.status,
    required this.messages,
    required this.errors,
  });

  @override
  List<Object?> get props => [
    status,
    messages,
    errors,
  ];
}
