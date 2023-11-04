import 'package:equatable/equatable.dart';

class RegisterFireAsDoctor extends Equatable {
  final String? uId;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? birthDate;
  final int? gender;
  final String? image;
  final bool? isPhoneVerify;
  final String? deviceToken;
  final int? role;

  const RegisterFireAsDoctor({
    this.uId,
    this.email,
    this.birthDate,
    this.gender,
    this.image,
    this.deviceToken,
    this.isPhoneVerify,
    this.phone,
    this.fullName,
    this.role,
  });

  @override
  List<Object?> get props => [
        uId,
        fullName,
        phone,
        isPhoneVerify,
        email,
        birthDate,
        gender,
        image,
        deviceToken,
      ];
}
