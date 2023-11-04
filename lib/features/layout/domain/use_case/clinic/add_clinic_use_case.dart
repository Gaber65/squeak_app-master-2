import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/domain/entites/clinic/add_clinic_entities.dart';

import '../../base_repository/base_clinic_repo.dart';

class AddClinicUseCase
    extends BaseUseCase<AddClinicEntities, AddClinicParameters> {
  BaseClinicRepo baseClinicRepo;

  AddClinicUseCase(this.baseClinicRepo);

  @override
  Future<Either<Failure, AddClinicEntities>> call(parameters) async {
    return await baseClinicRepo.addClinic(parameters);
  }
}
