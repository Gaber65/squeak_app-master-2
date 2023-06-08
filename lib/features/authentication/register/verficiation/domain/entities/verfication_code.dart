import 'package:equatable/equatable.dart';

class VerificationCode extends Equatable {
  final bool status;
  final String messages;

  const VerificationCode({
    required this.status,
    required this.messages,
  });

  @override
  List<Object?> get props => [
    status,
    messages,
  ];
}
