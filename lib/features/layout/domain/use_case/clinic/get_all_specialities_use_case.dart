import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/clinic/all_clinics_entities.dart';
import '../../entites/clinic/speciality_entities.dart';

class GetAllSpecialityUseCase extends BaseUseCase<SpecialitiesEntities, NoParameters> {
  BaseClinicRepo baseClinicRepo;

  GetAllSpecialityUseCase(this.baseClinicRepo);

  @override
  Future<Either<Failure, SpecialitiesEntities>> call(parameters) async {
    return await baseClinicRepo.allSpecialities();
  }
}
