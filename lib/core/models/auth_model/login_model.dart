import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final String uId;
  final String fullName;
  final String userName;
  final String birthdate;
  final String email;
  final String phone;
  final String image;

  Map<String, dynamic> toMap() {
    return {
      'name': fullName,
      'email': email,
      'userName': userName,
      'phone': phone,
      'image': image,
      'uId': uId,
      'birthdate': birthdate,
    };
  }

  const UserDataModel({
    required this.uId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.birthdate,
    required this.userName,
    this.image = '',
  });
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      email: json['email'],
      fullName: json['name'],
      phone: json['phone'],
      uId: json['uId'],
      image: json['image'],
      userName: json['userName'],
      birthdate: json['birthdate'],
    );
  }

  @override
  List<Object> get props => [
        uId,
        fullName,
        email,
        phone,
        image,
        userName,
      ];
}
