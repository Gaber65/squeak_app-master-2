import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/profile/domain/entities/profile.dart';
import 'package:squeak/features/layout/profile/domain/repository/base_profile_repository.dart';

class GetProfileUseCase extends BaseUseCase<Profile,NoParameters>
{
  final BaseProfileRepository baseProfileRepository;

  GetProfileUseCase(this.baseProfileRepository);
  @override
  Future<Either<Failure, Profile>> call(NoParameters parameters)async {
    return await baseProfileRepository.getProfile();
  }

}