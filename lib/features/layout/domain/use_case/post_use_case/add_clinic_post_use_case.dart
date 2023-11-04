import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/post/create_post_entites.dart';

class CreatePostClinicUseCase extends BaseUseCase<PostEntities, AddPostParameters> {
  BaseClinicRepo baseClinicRepo;
  CreatePostClinicUseCase(this.baseClinicRepo);
  @override
  Future<Either<Failure, PostEntities>> call(
      AddPostParameters parameters) async {
    return await baseClinicRepo.createPostClinic(parameters);
  }
}
