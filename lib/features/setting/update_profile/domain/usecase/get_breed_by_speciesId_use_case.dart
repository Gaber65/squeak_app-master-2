import 'package:dartz/dartz.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../entities/beeds_type_data.dart';
import '../repository/base_update_profile_repository.dart';

class GetBreedBySpeciesIdUseCase extends BaseUseCase<BreedEntities, GetBreedBySpeciesIdParameters> {
  final BaseUpdateProfileRepository baseUpdateProfileRepository;

  GetBreedBySpeciesIdUseCase(this.baseUpdateProfileRepository);

  @override
  Future<Either<Failure, BreedEntities>> call(GetBreedBySpeciesIdParameters parameters) async {
    return await baseUpdateProfileRepository.getBreedBySpeciesId(parameters);
  }
}
