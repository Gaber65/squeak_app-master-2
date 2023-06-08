import 'package:equatable/equatable.dart';

class ForgetPassword extends Equatable {
  final bool status;
  final String messages;

  const ForgetPassword({
    required this.status,
    required this.messages,
  });

  @override
  List<Object?> get props => [
    status,
    messages,
  ];
}
