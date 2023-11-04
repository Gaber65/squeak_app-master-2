import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/clinic/all_clinics_entities.dart';
import '../../entites/clinic/follow_clinic.dart';

class PostUnFollowClinicUseCase
    extends BaseUseCase<FollowEntites, FollowClinicParameters> {
  BaseClinicRepo baseClinicRepo;

  PostUnFollowClinicUseCase(this.baseClinicRepo);

  @override
  Future<Either<Failure, FollowEntites>> call(
      FollowClinicParameters parameters) async {
    return await baseClinicRepo.unfollowClinic(parameters);
  }
}
