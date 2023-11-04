import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../../../availability/data/model/availabilities/delete_availabilities_model.dart';
import '../../../../availability/domain/entities/availabilities/delete_availabilities_entities.dart';
import '../../base_repository/base_clinic_repo.dart';
import '../../entites/clinic/all_clinic_follower.dart';
import '../../entites/clinic/all_clinics_entities.dart';

class DeleteClinicUseCase extends BaseUseCase<DeleteAvailabilitiesEntities, FollowClinicParameters> {
  BaseClinicRepo baseClinicRepo;

  DeleteClinicUseCase(this.baseClinicRepo);

  @override
  Future<Either<Failure, DeleteAvailabilitiesEntities>> call(FollowClinicParameters parameters) async {
    return await baseClinicRepo.deleteClinic(parameters);
  }
}
