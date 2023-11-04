import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/post_pets_use_case.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../entities/add_peets_data.dart';
import '../repository/base_update_profile_repository.dart';

class PostVacPetsUseCase
    extends BaseUseCase<AddNewPetData, PostVacPetsParameters> {
  final BaseUpdateProfileRepository baseProfileRepository;

  PostVacPetsUseCase(this.baseProfileRepository);

  @override
  Future<Either<Failure, AddNewPetData>> call(
      PostVacPetsParameters parameters) async {
    return await baseProfileRepository.addVacPet(parameters);
  }
}

class PostVacPetsParameters extends Equatable {
  final String petId;
  final String vaccinationId;
  final String vacDate;
  final String comment;
  final bool statues;

  const PostVacPetsParameters({
    required this.petId,
    required this.vacDate,
    required this.comment,
    required this.statues,
    required this.vaccinationId,
  });

  @override
  List<Object> get props => [
        petId,
        vaccinationId,
        vacDate,
        comment,
        statues,
      ];
}
