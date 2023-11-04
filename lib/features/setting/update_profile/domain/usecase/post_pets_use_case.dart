import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../entities/add_peets_data.dart';
import '../repository/base_update_profile_repository.dart';


class PostPetsUseCase extends BaseUseCase<AddNewPetData, PostPetsParameters> {
  final BaseUpdateProfileRepository baseProfileRepository;

  PostPetsUseCase(this.baseProfileRepository);

  @override
  Future<Either<Failure, AddNewPetData>> call(
      PostPetsParameters parameters) async {
    return await baseProfileRepository.postPets(parameters);
  }
}

class PostPetsParameters extends Equatable {
  final String petName;
  final int gender;
  final String birthdate;
  final String imageName;
  final String ownerClientId;
  final String breedId;

  const PostPetsParameters({
    required this.petName,
    required this.gender,
    required this.birthdate,
    required this.imageName,
    required this.ownerClientId,
    required this.breedId,
  });

  @override
  List<Object> get props => [
        petName,
        gender,
        birthdate,
        imageName,
        ownerClientId,
        breedId!,
      ];
}
