import 'package:dartz/dartz.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../entities/vaccination_entities.dart';
import '../repository/base_update_profile_repository.dart';

class GetAllVacPetUseCase extends BaseUseCase<VacEntities, GetVacByPetIdParameters> {
  final BaseUpdateProfileRepository baseUpdateProfileRepository;

  GetAllVacPetUseCase(this.baseUpdateProfileRepository);

  @override
  Future<Either<Failure, VacEntities>> call(GetVacByPetIdParameters parameters) async {
    return await baseUpdateProfileRepository.getVacPet(parameters);
  }
}
