import 'package:squeak/features/authentication/register/register_as_a_doctor/domain/entities/firebase_register_doctor.dart';

class RegisterFireAsDoctorModel extends RegisterFireAsDoctor {
  const RegisterFireAsDoctorModel({
    super.uId,
    super.fullName,
    super.email,
    super.birthDate,
    super.gender,
    super.image,
    super.deviceToken,
    super.phone,
    super.isPhoneVerify,
    super.role,

  });
  factory RegisterFireAsDoctorModel.fromJson(Map<String, dynamic> json) =>
      RegisterFireAsDoctorModel(
        uId: json['uId'],
        fullName:  json['fullName'],
        email:  json['email'],
        birthDate:  json['birthdate'],
        gender:  json['gender'],
        image:  json['image'],
        deviceToken: json['deviceToken'],
        isPhoneVerify: json['isPhoneVerify'],
        phone: json['phone'],
        role: json['role'],
      );

  Map<String , dynamic> toMap()
  {
    return
      {
        'uId':uId,
        'email':email,
        'fullName':fullName,
        'birthdate':birthDate,
        'gender':gender,
        'image':image,
        'deviceToken':deviceToken,
        'phone':phone,
        'isPhoneVerify':isPhoneVerify,
        'role':role,
      };
  }
}
