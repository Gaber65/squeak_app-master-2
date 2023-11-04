import 'package:dartz/dartz.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../repository/base_update_profile_repository.dart';

class GetAllSpeciesUseCase extends BaseUseCase<SpeciesEntities, NoParameters> {
  final BaseUpdateProfileRepository baseUpdateProfileRepository;

  GetAllSpeciesUseCase(this.baseUpdateProfileRepository);

  @override
  Future<Either<Failure, SpeciesEntities>> call(NoParameters parameters) async {
    return await baseUpdateProfileRepository.getAllSpecies();
  }
}
