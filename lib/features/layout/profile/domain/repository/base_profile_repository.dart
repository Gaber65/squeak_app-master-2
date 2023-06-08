import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/layout/profile/domain/entities/profile.dart';
import 'package:squeak/features/layout/profile/domain/entities/species_entities.dart';

import '../entities/owner_pets.dart';
import '../entities/pets_entities.dart';
import '../usecase/get_breeds_use_case.dart';
import '../usecase/post_pets_use_case.dart';
import '../usecase/update_pits_use_case.dart';

abstract class BaseProfileRepository
{
  Future<Either<Failure,Profile>>getProfile();
  Future<Either<Failure,OwnerPetsEntities>>getOwnerPets();

  Future<Either<Failure,PetsEntities>>postPets(PostPetsParameters parameters);
  Future<Either<Failure,SpeciesEntities>>getBreeds(GetBreedParameters parameters );
  Future<Either<Failure,PetsEntities>>updatePets(UpdatePetsParameters parameters);

}