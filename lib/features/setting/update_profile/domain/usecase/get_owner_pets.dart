import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import 'package:squeak/features/setting/update_profile/domain/entities/find_pet_by_owner_id_data.dart';
import 'package:squeak/features/setting/update_profile/domain/repository/base_update_profile_repository.dart';


class GetOwnerPetsUseCase extends BaseUseCase<FindPetByOwnerIdData,NoParameters>
{
  final BaseUpdateProfileRepository baseProfileRepository;

  GetOwnerPetsUseCase(this.baseProfileRepository);
  @override
  Future<Either<Failure, FindPetByOwnerIdData>> call(NoParameters parameters)async {
    return await baseProfileRepository.getOwnerPets();
  }

}