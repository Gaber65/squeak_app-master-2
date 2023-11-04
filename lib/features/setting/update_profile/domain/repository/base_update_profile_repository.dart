import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/post_pets_use_case.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/update_pits_use_case.dart';

import '../../../../../core/error/failure.dart';
import '../entities/add_peets_data.dart';
import '../entities/beeds_type_data.dart';
import '../entities/find_pet_by_owner_id_data.dart';
import '../entities/update_profile.dart';
import '../entities/vaccination_entities.dart';
import '../usecase/add_vac_pet_use_case.dart';
import '../usecase/delete_pet_use_case.dart';

abstract class BaseUpdateProfileRepository {
  Future<Either<Failure, UpdateProfile>> getUpdateProfile(
      UpdateProfileParameters parameters);

  Future<Either<Failure, SpeciesEntities>> getAllSpecies();

  Future<Either<Failure, BreedEntities>> getBreedBySpeciesId(
      GetBreedBySpeciesIdParameters getBreedBySpeciesIdParameters);

  Future<Either<Failure, AddNewPetData>> postPets(
      PostPetsParameters parameters);

  Future<Either<Failure, FindPetByOwnerIdData>> getOwnerPets();

  Future<Either<Failure, AddNewPetData>> updatePets(
      UpdatePetsParameters parameters);

  Future<Either<Failure, AddNewPetData>> deletePets(
      DeletePetParameters parameters);

  Future<Either<Failure, AddNewPetData>> addVacPet(
      PostVacPetsParameters parameters);

  Future<Either<Failure, VacEntities>> getVac();

  Future<Either<Failure, VacEntities>> getVacPet(GetVacByPetIdParameters parameters);
}

class UpdateProfileParameters extends Equatable {
  final String userName;
  final String imageName;
  final String birthDate;
  final int gender;
  final String fullName;
  final String address;
  final String phoneNumber;
  final int userType;

  const UpdateProfileParameters({
    required this.fullName,
    required this.imageName,
    required this.address,
    required this.birthDate,
    required this.phoneNumber,
    required this.userName,
    required this.userType,
    required this.gender,
  });

  @override
  List<Object> get props => [
        userName,
        imageName,
        birthDate,
        gender,
        fullName,
        address,
        phoneNumber,
        userType,
      ];
}

class GetBreedBySpeciesIdParameters extends Equatable {
  final String speciesId;

  const GetBreedBySpeciesIdParameters({
    required this.speciesId,
  });

  @override
  List<Object?> get props => [
    speciesId,
  ];
}

class GetVacByPetIdParameters extends Equatable {
  final String petId;

  const GetVacByPetIdParameters({
    required this.petId,
  });

  @override
  List<Object?> get props => [
    petId,
  ];
}
