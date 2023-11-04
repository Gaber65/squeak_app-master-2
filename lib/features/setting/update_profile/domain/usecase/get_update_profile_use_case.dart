import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../entities/update_profile.dart';
import '../repository/base_update_profile_repository.dart';

class GetUpdateProfileUseCase extends BaseUseCase<UpdateProfile,UpdateProfileParameters>
{
  final BaseUpdateProfileRepository baseUpdateProfileRepository;

  GetUpdateProfileUseCase(this.baseUpdateProfileRepository);
  @override
  Future<Either<Failure, UpdateProfile>> call(UpdateProfileParameters parameters)async {
    return await baseUpdateProfileRepository.getUpdateProfile(parameters);
  }

}