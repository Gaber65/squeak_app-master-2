import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/profile/domain/repository/base_profile_repository.dart';

import '../entities/species_entities.dart';

class GetBreedsUseCase
    extends BaseUseCase<SpeciesEntities, GetBreedParameters> {
  final BaseProfileRepository baseProfileRepository;

  GetBreedsUseCase(this.baseProfileRepository);
  @override
  Future<Either<Failure, SpeciesEntities>> call(
      GetBreedParameters parameters) async {
    return await baseProfileRepository.getBreeds(parameters);
  }
}

class GetBreedParameters extends Equatable {
  final int speciesId;

  const GetBreedParameters({required this.speciesId});

  @override
  List<Object> get props => [
        speciesId,
      ];
}
