import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/exception.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/setting/profile/data/datasource/base_profile_remote_data_source.dart';
import 'package:squeak/features/setting/profile/data/model/profile_model.dart';
import 'package:squeak/features/setting/profile/domain/entities/contact_us_entites.dart';
import 'package:squeak/features/setting/profile/domain/entities/profile.dart';
import 'package:squeak/features/setting/profile/domain/repository/base_profile_repository.dart';

import '../../domain/usecase/post_contactUs_use_case.dart';

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
  Future<Either<Failure, ContactUsEntites>> postContactUs(TicketParameters parameters) async{
    final result = await baseProfileRemoteDataSource.postContactUsProfile(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }


}
