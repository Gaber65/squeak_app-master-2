import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/domain/entites/clinic/add_clinic_entities.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/vac/vaccination_entities.dart';

class GetVaccinationUseCase extends BaseUseCase<VaccinationEntities,VaccinationParameters> {
  BaseClinicRepo baseClinicRepo;

  GetVaccinationUseCase(this.baseClinicRepo);

  @override
  Future<Either<Failure, VaccinationEntities>> call(VaccinationParameters parameters) async {
    return await baseClinicRepo.getVaccinationPet(parameters);
  }
}
