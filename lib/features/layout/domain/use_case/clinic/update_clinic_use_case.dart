import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/domain/entites/clinic/add_clinic_entities.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/clinic/all_clinics_entities.dart';

class UpdateClinicUseCase
    extends BaseUseCase<AllClinicEntities, AddClinicParameters> {
  BaseClinicRepo baseClinicRepo;

  UpdateClinicUseCase(this.baseClinicRepo);

  @override
  Future<Either<Failure, AllClinicEntities>> call(AddClinicParameters parameters) async {
    return await baseClinicRepo.updateClinic(parameters);
  }
}
