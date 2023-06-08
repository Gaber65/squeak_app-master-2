import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/profile/domain/entities/profile.dart';
import 'package:squeak/features/layout/profile/domain/repository/base_profile_repository.dart';

import '../entities/owner_pets.dart';

class GetOwnerPetsUseCase extends BaseUseCase<OwnerPetsEntities,NoParameters>
{
  final BaseProfileRepository baseProfileRepository;

  GetOwnerPetsUseCase(this.baseProfileRepository);
  @override
  Future<Either<Failure, OwnerPetsEntities>> call(NoParameters parameters)async {
    return await baseProfileRepository.getOwnerPets();
  }

}