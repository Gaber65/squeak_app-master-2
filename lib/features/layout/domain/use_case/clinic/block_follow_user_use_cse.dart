import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/clinic/all_clinics_entities.dart';
import '../../entites/clinic/follow_clinic.dart';

class PostBlockUserFollowClinicUseCase extends BaseUseCase<FollowEntites, BlockUserClinicParameters> {
  BaseClinicRepo baseClinicRepo;

  PostBlockUserFollowClinicUseCase(this.baseClinicRepo);

  @override
  Future<Either<Failure, FollowEntites>> call(BlockUserClinicParameters parameters) async {
    return await baseClinicRepo.blockFollowUser(parameters);
  }
}
