import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/domain/entites/clinic/add_clinic_entities.dart';

import '../../base_repository/base_clinic_repo.dart';

class AddVaccinationUseCase extends BaseUseCase2<void, VaccinationParameters> {
  BaseClinicRepo baseClinicRepo;

  AddVaccinationUseCase(this.baseClinicRepo);

  @override
  Future<void> call(VaccinationParameters parameters) async {
    return await baseClinicRepo.addVaccination(parameters);
  }
}
