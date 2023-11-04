import 'package:dartz/dartz.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/add_peets_data.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/beeds_type_data.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/vaccination_entities.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/add_vac_pet_use_case.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/delete_pet_use_case.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/post_pets_use_case.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/update_pits_use_case.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/end-points.dart';
import '../../domain/entities/update_profile.dart';
import '../../domain/repository/base_update_profile_repository.dart';
import '../datasource/base_update_profile_data_source.dart';
import '../model/beeds_type_model.dart';
import '../model/find_pet_by_owner_id_model.dart';

class UpdateProfileRepository extends BaseUpdateProfileRepository {
  final BaseUpdateProfileRemoteDataSource baseUpdateProfileRemoteDataSource;

  UpdateProfileRepository(this.baseUpdateProfileRemoteDataSource);

  @override
  Future<Either<Failure, UpdateProfile>> getUpdateProfile(
      UpdateProfileParameters parameters) async {
    final result =
        await baseUpdateProfileRemoteDataSource.getUpdateProfile(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, SpeciesEntities>> getAllSpecies() async {
    final result = await baseUpdateProfileRemoteDataSource.getAllSpecies();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, BreedEntities>> getBreedBySpeciesId(
      GetBreedBySpeciesIdParameters getBreedBySpeciesIdParameters) async {
    final result = await baseUpdateProfileRemoteDataSource
        .getBreedBySpeciesId(getBreedBySpeciesIdParameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, FindPetByOwnerIdModel>> getOwnerPets() async {
    final result =
        await baseUpdateProfileRemoteDataSource.getPetOwnerByBaseDataSource();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AddNewPetData>> postPets(
      PostPetsParameters parameters) async {
    final result = await baseUpdateProfileRemoteDataSource
        .postPetsBaseDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AddNewPetData>> updatePets(
      UpdatePetsParameters parameters) async {
    final result = await baseUpdateProfileRemoteDataSource
        .upDatePetsBaseDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, VacEntities>> getVac() async {
    final result =
        await baseUpdateProfileRemoteDataSource.getAllVacBaseDataSource();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AddNewPetData>> addVacPet(
      PostVacPetsParameters parameters) async {
    final result = await baseUpdateProfileRemoteDataSource
        .postVacPetsBaseDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AddNewPetData>> deletePets(
      DeletePetParameters parameters) async {
    final result = await baseUpdateProfileRemoteDataSource
        .deletePetsBaseDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, VacEntities>> getVacPet(
      GetVacByPetIdParameters parameters) async {
    // TODO: implement getVacPet
    final result = await baseUpdateProfileRemoteDataSource
        .getVacPetBaseDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }
}
