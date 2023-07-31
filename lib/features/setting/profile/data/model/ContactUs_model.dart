import '../../domain/entities/contact_us_entites.dart';

class ContactUsModel extends ContactUsEntites {
  const ContactUsModel(
      {required super.status, required super.message, required super.data});

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      status: json['statusCode'],
      message: json['message'],
      data: ContactUsDataModel.fromJson(json['data']),
    );
  }
}

class ContactUsDataModel extends ContactUsData {
  const ContactUsDataModel({required super.ticket});

  factory ContactUsDataModel.fromJson(Map<String, dynamic> json) {
    return ContactUsDataModel(
      ticket: TicketModel.fromJson(json['ticket']),
    );
  }
}

class TicketModel extends Ticket {
  const TicketModel({
    required super.ticketNumber,
    required super.title,
    required super.phone,
    required super.comment,
    required super.email,
    required super.statues,
  });
  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketNumber: json['ticketNumber'],
      title: json['title'],
      phone: json['phone'],
      comment: json['comment'],
      email: json['email'],
      statues: json['statues'],
      
    );
  }
}
