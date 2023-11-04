import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/layout/data/data_source/base_clinic_data_source.dart';
import 'package:squeak/features/layout/data/models/vaccination_model.dart';
import 'package:squeak/features/layout/domain/base_repository/base_clinic_repo.dart';
import 'package:squeak/features/layout/domain/entites/clinic/add_clinic_entities.dart';
import 'package:squeak/features/layout/domain/entites/clinic/all_clinics_entities.dart';
import 'package:squeak/features/layout/domain/entites/clinic/get_follower_clinic_entities.dart';
import 'package:squeak/features/layout/domain/entites/post/create_post_entites.dart';

import 'package:squeak/features/layout/domain/entites/vac/vaccination_entities.dart';

import '../../../../core/error/exception.dart';
import '../../../availability/domain/entities/availabilities/delete_availabilities_entities.dart';
import '../../domain/entites/clinic/all_clinic_follower.dart';
import '../../domain/entites/clinic/follow_clinic.dart';
import '../../domain/entites/clinic/speciality_entities.dart';
import '../../domain/entites/post/get_doctor_post_entitites.dart';
import '../../domain/use_case/post_use_case/get_doctor_posts_use_case.dart';

class ClinicRepository extends BaseClinicRepo {
  final BaseClinicRemoteDataSource baseClinicRemoteDataSource;

  ClinicRepository(this.baseClinicRemoteDataSource);

  @override
  Future<Either<Failure, AddClinicEntities>> addClinic(
      AddClinicParameters parameters) async {
    final result =
        await baseClinicRemoteDataSource.addClinicDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, FollowEntites>> followClinic(
      FollowClinicParameters parameters) async {
    final result =
        await baseClinicRemoteDataSource.followClinicsDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, FollowEntites>> unfollowClinic(
      FollowClinicParameters parameters) async {
    final result =
        await baseClinicRemoteDataSource.unfollowClinicsDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AllClinicFollowerEntities>> allFollowClinic(
      AllFollowClinicParameters parameters) async {
    final result =
        await baseClinicRemoteDataSource.allClinicsFollowDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future addVaccination(VaccinationParameters parameters) async {
    final result = await baseClinicRemoteDataSource.addVaccination(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, VaccinationEntities>> getVaccinationPet(VaccinationParameters parameters) async {
    final result = await baseClinicRemoteDataSource.getVaccination(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, VaccinationNameEntities>> getVaccinationName(
      VaccinationNameParameters parameters) async {
    final result =
        await baseClinicRemoteDataSource.getVaccinationName(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, VaccinationModel>> updateVaccination(
      VaccinationParameters parameters) async {
    final result =
        await baseClinicRemoteDataSource.updateVaccination(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, SpecialitiesEntities>> allSpecialities() async {
    final result = await baseClinicRemoteDataSource.allSpecialitiesDataSource();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }



  @override
  Future<Either<Failure, FollowEntites>> blockFollowUser(
      BlockUserClinicParameters parameters) async {
    final result = await baseClinicRemoteDataSource
        .blockUserFollowClinicsDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AllClinicEntities>> allClinic(AllFollowClinicParameters parameters)async {
    final result = await baseClinicRemoteDataSource.allClinicsDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, PostEntities>> createPostClinic(AddPostParameters parameters) async{
    // TODO: implement createPostClinic
    final result = await baseClinicRemoteDataSource.createClinicPostDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, PostEntities>> deletePostClinic(AddPostParameters parameters) async{
    final result = await baseClinicRemoteDataSource.deleteClinicPostDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, PostDoctorEntities>> getClinicPosts(GetPostParameters parameters) async{
    final result = await baseClinicRemoteDataSource.getClinicPostDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, PostEntities>> updatePostClinic(AddPostParameters parameters) async{
    final result = await baseClinicRemoteDataSource.updateClinicPostDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AllClinicEntities>> allClinicSupplier(AllFollowClinicParameters parameters) async{
    final result = await baseClinicRemoteDataSource.allClinicsSupplierDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AllClinicEntities>> updateClinic(AddClinicParameters parameters) async{
    final result = await baseClinicRemoteDataSource.updateClinicDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, DeleteAvailabilitiesEntities>> deleteClinic(FollowClinicParameters parameters)async {
    final result = await baseClinicRemoteDataSource.deleteClinicDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, PostDoctorEntities>> getDoctorPosts(GetPostParameters parameters) async{
    final result = await baseClinicRemoteDataSource.getDoctorClinicPostDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, ClinicFollowersEntities>> getFollowersClinic()async {
    final result = await baseClinicRemoteDataSource.getFollowerClinicDataSource();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    };
  }
}
