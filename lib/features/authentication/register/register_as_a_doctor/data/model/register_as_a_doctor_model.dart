
import '../../domain/entities/register_as_a_doctor.dart';

class RegisterAsADoctorModel extends RegisterAsADoctor {
  const RegisterAsADoctorModel({
    required super.data,
    required super.status,
    required super.messages,
  });

  factory RegisterAsADoctorModel.fromJson(Map<String, dynamic> json) {
    return RegisterAsADoctorModel(
      data: json['data'] != null ? DataAsADoctorModel.fromJson(json['data']) : null,
      status: json['status'],
      messages: json['messages'],
    );
  }
}

class DataAsADoctorModel extends DataAsADoctor {
  const DataAsADoctorModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.role,
  });

  factory DataAsADoctorModel.fromJson(Map<String, dynamic> json) {
    return DataAsADoctorModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}
