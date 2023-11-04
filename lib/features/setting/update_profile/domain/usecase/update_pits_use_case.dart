import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/setting/update_profile/domain/repository/base_update_profile_repository.dart';


import '../entities/add_peets_data.dart';



class UpdatePetsUseCase
    extends BaseUseCase<AddNewPetData, UpdatePetsParameters> {
  final BaseUpdateProfileRepository baseProfileRepository;

  UpdatePetsUseCase(this.baseProfileRepository);

  @override
  Future<Either<Failure, AddNewPetData>> call(
      UpdatePetsParameters parameters) async {
    return await baseProfileRepository.updatePets(parameters);
  }
}

class UpdatePetsParameters extends Equatable {
  final String petName;
  final String petId;
  final int gender;
  final String birthdate;
  final String image;
  final String ownerClientId;
  final String breedId;

   UpdatePetsParameters({
    required this.petName,
    required this.gender,
    required this.birthdate,
    required this.image,
    required this.ownerClientId,
    required this.breedId,
    required this.petId,
  });

  @override
  List<Object> get props => [
    petName,
    gender,
    petId,
    birthdate,
    image,
    ownerClientId,
    breedId!,
  ];
}
