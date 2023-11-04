import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/clinic/all_clinics_entities.dart';
import '../../entites/vac/vaccination_entities.dart';

class GetAllVaccinationNameUseCase
    extends BaseUseCase<VaccinationNameEntities, VaccinationNameParameters> {
  BaseClinicRepo baseClinicRepo;

  GetAllVaccinationNameUseCase(this.baseClinicRepo);

  @override
  Future<Either<Failure, VaccinationNameEntities>> call(
      VaccinationNameParameters parameters) async {
    return await baseClinicRepo.getVaccinationName(parameters);
  }
}
