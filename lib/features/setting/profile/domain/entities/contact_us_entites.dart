import 'package:equatable/equatable.dart';

class ContactUsEntites extends Equatable {
  final dynamic status;
  final dynamic message;
  final ContactUsData data;

  const ContactUsEntites({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object> get props => [
        status,
        message,
        data,
      ];
}

class ContactUsData extends Equatable {
  final Ticket ticket;

  const ContactUsData({
    required this.ticket,
  });

  @override
  List<Object> get props => [
        ticket,
      ];
}

class Ticket extends Equatable {
  const Ticket({
    required this.ticketNumber,
    required this.title,
    required this.phone,
    required this.comment,
    required this.email,
    required this.statues,
  });

  final int ticketNumber;
  final String title;
  final String phone;
  final String comment;
  final String email;
  final bool statues;

  @override
  List<Object?> get props => [
        ticketNumber,
        title,
        phone,
        comment,
        email,
        statues,
      ];
}
