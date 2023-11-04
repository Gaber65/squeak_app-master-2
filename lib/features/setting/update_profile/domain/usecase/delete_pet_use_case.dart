import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/update_pits_use_case.dart';

import '../entities/add_peets_data.dart';
import '../repository/base_update_profile_repository.dart';

class DeletePetsUseCase
    extends BaseUseCase<AddNewPetData, DeletePetParameters> {
  final BaseUpdateProfileRepository baseProfileRepository;

  DeletePetsUseCase(this.baseProfileRepository);

  @override
  Future<Either<Failure, AddNewPetData>> call(
      DeletePetParameters parameters) async {
    return await baseProfileRepository.deletePets(parameters);
  }
}

class DeletePetParameters extends Equatable {
  final String petId;

  const DeletePetParameters({required this.petId});

  @override
  List<Object> get props => [petId];
}
