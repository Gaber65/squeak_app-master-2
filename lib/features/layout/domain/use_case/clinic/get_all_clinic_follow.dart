import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/clinic/all_clinic_follower.dart';
import '../../entites/clinic/all_clinics_entities.dart';

class GetAllClinicFollowUseCase extends BaseUseCase<AllClinicFollowerEntities, AllFollowClinicParameters> {
  BaseClinicRepo baseClinicRepo;

  GetAllClinicFollowUseCase(this.baseClinicRepo);

  @override
  Future<Either<Failure, AllClinicFollowerEntities>> call(AllFollowClinicParameters parameters) async {
    return await baseClinicRepo.allFollowClinic(parameters);
  }
}
