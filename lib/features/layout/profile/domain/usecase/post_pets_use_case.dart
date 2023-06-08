import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/profile/domain/repository/base_profile_repository.dart';

import '../entities/pets_entities.dart';

class PostPetsUseCase extends BaseUseCase<PetsEntities, PostPetsParameters> {
  final BaseProfileRepository baseProfileRepository;

  PostPetsUseCase(this.baseProfileRepository);

  @override
  Future<Either<Failure, PetsEntities>> call(
      PostPetsParameters parameters) async {
    return await baseProfileRepository.postPets(parameters);
  }
}

class PostPetsParameters extends Equatable {
  final String petName;
  final int gender;
  final int species;
  final String birthdate;
  final File image;
  final String imageName;
  final String ownerClientId;
  final String breedId;

  const PostPetsParameters({
    required this.petName,
    required this.gender,
    required this.species,
    required this.birthdate,
    required this.image,
    required this.imageName,
    required this.ownerClientId,
    required this.breedId,
  });

  @override
  List<Object> get props => [
        petName,
        gender,
        species,
        birthdate,
        image,
        imageName,
        ownerClientId,
        breedId!,
      ];
}
