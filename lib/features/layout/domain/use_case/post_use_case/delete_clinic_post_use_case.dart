import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/post/create_post_entites.dart';

class DeletePostClinicUseCase
    extends BaseUseCase<PostEntities, AddPostParameters> {
  BaseClinicRepo baseClinicRepo;
  DeletePostClinicUseCase(this.baseClinicRepo);
  @override
  Future<Either<Failure, PostEntities>> call(
      AddPostParameters parameters) async {
    return await baseClinicRepo.deletePostClinic(parameters);
  }
}
