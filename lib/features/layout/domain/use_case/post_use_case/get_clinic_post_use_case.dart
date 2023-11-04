import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/post/create_post_entites.dart';
import '../../entites/post/get_doctor_post_entitites.dart';
import 'get_doctor_posts_use_case.dart';

class GetPostClinicUseCase extends BaseUseCase<PostDoctorEntities, GetPostParameters> {
  BaseClinicRepo baseClinicRepo;
  GetPostClinicUseCase(this.baseClinicRepo);
  @override
  Future<Either<Failure, PostDoctorEntities>> call(GetPostParameters parameters) async {
    return await baseClinicRepo.getClinicPosts(parameters);
  }
}
