import 'package:dartz/dartz.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/end-points.dart';
import '../../../../../core/service/dio_client.dart';
import '../../../../../core/service/server_error.dart';
import '../../domain/entities/update_profile.dart';
import '../../domain/repository/base_update_profile_repository.dart';
import '../datasource/base_update_profile_data_source.dart';
import '../model/beeds_type_model.dart';

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
}
