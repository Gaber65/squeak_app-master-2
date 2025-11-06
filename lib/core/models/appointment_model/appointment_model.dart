import 'package:equatable/equatable.dart';

class AppointmentModel extends Equatable {
  final String fullName;
  final String userName;
  final String birthdate;
  final String hotialName;
  final String hotialImage;
  final dynamic startDate;
  final dynamic endDate;
  final String email;
  final String phone;
  final int numOfAdults;
  final int numOfYoung;

  Map<String, dynamic> toMap() {
    return {
      'name': fullName,
      'email': email,
      'userName': userName,
      'phone': phone,
      'birthdate': birthdate,
      'numOfYoung': numOfYoung,
      'numOfAdults': numOfAdults,
      'startDate': startDate,
      'endDate': endDate,
      'hotialImage': hotialImage,
      'hotialName': hotialName,
    };
  }

  const AppointmentModel({
    required this.fullName,
    required this.hotialName,
    required this.hotialImage,
    required this.email,
    required this.phone,
    required this.birthdate,
    required this.userName,
    required this.numOfAdults,
    required this.numOfYoung,
    required this.endDate,
    required this.startDate,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      email: json['email'],
      hotialName: json['hotialName'],
      hotialImage: json['hotialImage'],
      fullName: json['name'],
      phone: json['phone'],
      userName: json['userName'],
      birthdate: json['birthdate'],
      numOfYoung: json['numOfYoung'],
      numOfAdults: json['numOfAdults'],
      endDate: json['endDate'],
      startDate: json['startDate'],
    );
  }

  @override
  List<Object> get props =>
      [
        fullName,
        userName,
        birthdate,
        startDate,
        endDate,
        email,
        phone,
        numOfAdults,
        numOfYoung,
        hotialName,
        hotialImage
      ];
}