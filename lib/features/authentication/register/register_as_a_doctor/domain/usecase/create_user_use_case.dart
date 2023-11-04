import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../entities/firebase_register_doctor.dart';
import '../repository/base_register_as_a_doctor.dart';

class CreateUserUseCase extends BaseUseCase2<void, CreateUserParameters> {
  final BaseRegisterAsADoctorRepository authBaseRepository;

  CreateUserUseCase(this.authBaseRepository);

  @override
  Future call(CreateUserParameters parameters) async {
    return await authBaseRepository.createUser(parameters);
  }
}

class CreateUserParameters extends Equatable {
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

  const CreateUserParameters({
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
        email,
        phone,
        birthDate,
        gender,
        image,
        isPhoneVerify,
        deviceToken,
        role,
      ];
}
