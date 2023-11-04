
import '../../../../login/data/model/login_model.dart';
import '../../domain/entities/register_as_a_doctor.dart';

class RegisterAsADoctorModel extends RegisterAsADoctor {
  const RegisterAsADoctorModel({
    required super.data,
    required super.status,
    required super.messages,
    required super.statusCode,
    required super.errors,
  });

  factory RegisterAsADoctorModel.fromJson(Map<String, dynamic> json) {
    return RegisterAsADoctorModel(
      data:json['data'],
      status: json['success'],
      messages: json['message'],
      errors: Map<String, List<dynamic>>.from(json['errors']),
      statusCode: json['statusCode'],
    );
  }
}

class DataAsADoctorModel extends DataAsADoctor {
  const DataAsADoctorModel({
    required super.token,
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.role,
  });

  factory DataAsADoctorModel.fromJson(Map<String, dynamic> json) {
    return DataAsADoctorModel(
      token: json['token'],
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      role: json['userType'],
    );
  }
}
