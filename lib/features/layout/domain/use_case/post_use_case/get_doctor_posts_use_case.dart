import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../base_repository/base_clinic_repo.dart';
import '../../entites/post/create_post_entites.dart';
import '../../entites/post/get_doctor_post_entitites.dart';

class GetDoctorPostClinicUseCase
    extends BaseUseCase<PostDoctorEntities, GetPostParameters> {
  BaseClinicRepo baseClinicRepo;

  GetDoctorPostClinicUseCase(this.baseClinicRepo);

  @override
  Future<Either<Failure, PostDoctorEntities>> call(
      GetPostParameters parameters) async {
    return await baseClinicRepo.getDoctorPosts(parameters);
  }
}

class GetPostParameters extends Equatable {
  final int pageNumber;

  const GetPostParameters({
    required this.pageNumber,
  });

  @override
  List<Object> get props => [
        pageNumber,
      ];
}
