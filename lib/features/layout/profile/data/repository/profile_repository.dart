import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/exception.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/layout/profile/data/datasource/base_profile_remote_data_source.dart';
import 'package:squeak/features/layout/profile/data/model/profile_model.dart';
import 'package:squeak/features/layout/profile/domain/entities/owner_pets.dart';
import 'package:squeak/features/layout/profile/domain/entities/pets_entities.dart';
import 'package:squeak/features/layout/profile/domain/entities/profile.dart';
import 'package:squeak/features/layout/profile/domain/entities/species_entities.dart';
import 'package:squeak/features/layout/profile/domain/repository/base_profile_repository.dart';
import 'package:squeak/features/layout/profile/domain/usecase/update_pits_use_case.dart';

import '../../domain/usecase/get_breeds_use_case.dart';
import '../../domain/usecase/post_pets_use_case.dart';

class ProfileRepository extends BaseProfileRepository {
  final BaseProfileRemoteDataSource baseProfileRemoteDataSource;

  ProfileRepository(this.baseProfileRemoteDataSource);
  @override
  Future<Either<Failure, Profile>> getProfile() async {
    final result = await baseProfileRemoteDataSource.getProfile();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, PetsEntities>> postPets(
      PostPetsParameters parameters) async {
    final result =
        await baseProfileRemoteDataSource.postPetsBaseDataSource(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, SpeciesEntities>> getBreeds(
      GetBreedParameters parameters) async {
    final result =
        await baseProfileRemoteDataSource.getBreedBaseDataSource(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, OwnerPetsEntities>> getOwnerPets() async {
    final result =
        await baseProfileRemoteDataSource.getOwnerPetsBaseDataSource();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.statusErrorMessageModel.message),
      );
    }
  }

  @override
  Future<Either<Failure, PetsEntities>> updatePets(
      UpdatePetsParameters parameters) async {
    final result =
        await baseProfileRemoteDataSource.upDatePetsBaseDataSource(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.statusErrorMessageModel.message),
      );
    }
  }
}
