import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/profile/domain/repository/base_profile_repository.dart';

import '../entities/pets_entities.dart';

class UpdatePetsUseCase
    extends BaseUseCase<PetsEntities, UpdatePetsParameters> {
  final BaseProfileRepository baseProfileRepository;

  UpdatePetsUseCase(this.baseProfileRepository);

  @override
  Future<Either<Failure, PetsEntities>> call(
      UpdatePetsParameters parameters) async {
    return await baseProfileRepository.updatePets(parameters);
  }
}

class UpdatePetsParameters extends Equatable {
  final String petId;
  final String petName;
  final int gender;
  final int species;
  final String birthdate;
  final File image;

  const UpdatePetsParameters({
    required this.petId,
    required this.gender,
    required this.petName,
    required this.image,
    required this.species,
    required this.birthdate,
  });

  @override
  @override
  List<Object> get props => [
        petId,
        petName,
        gender,
        species,
        birthdate,
        image,
      ];
}
