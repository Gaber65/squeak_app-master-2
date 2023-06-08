import 'package:equatable/equatable.dart';

class ResetPassword extends Equatable {
  final bool status;
  final String messages;

  const ResetPassword({
    required this.status,
    required this.messages,
  });

  @override
  List<Object?> get props => [
    status,
    messages,
  ];
}
