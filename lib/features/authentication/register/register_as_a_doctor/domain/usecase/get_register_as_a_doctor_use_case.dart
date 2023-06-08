import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../entities/register_as_a_doctor.dart';
import '../repository/base_register_as_a_doctor.dart';




class GetRegisterAsADoctorUseCase extends BaseUseCase<RegisterAsADoctor,RegisterAsADoctorParameters>
{
  final BaseRegisterAsADoctorRepository baseRegisterAsADoctorRepository;

  GetRegisterAsADoctorUseCase(this.baseRegisterAsADoctorRepository);
  @override
  Future<Either<Failure, RegisterAsADoctor>> call(RegisterAsADoctorParameters parameters)async {
    return await baseRegisterAsADoctorRepository.getRegisterAsADoctor(parameters);
  }

}