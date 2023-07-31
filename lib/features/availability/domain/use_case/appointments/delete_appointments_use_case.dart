import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../entities/availabilities/delete_availabilities_entities.dart';
import '../../repository/base_availabilities_repository.dart';


class DeleteAvailabilitiesUseCase extends BaseUseCase<DeleteAvailabilitiesEntities, GetAvailabilitiesParameters> {
  final BaseAvailabilitiesRepository baseAvailabilitiesRepository;

  DeleteAvailabilitiesUseCase(this.baseAvailabilitiesRepository);

  @override
  Future<Either<Failure, DeleteAvailabilitiesEntities>> call(GetAvailabilitiesParameters parameters)async {
    return await baseAvailabilitiesRepository.deleteAvailabilities(parameters);
  }
}

