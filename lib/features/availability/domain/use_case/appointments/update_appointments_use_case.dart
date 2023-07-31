import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../entities/availabilities/create_availabilities_entities.dart';
import '../../repository/base_availabilities_repository.dart';


class UpdateAvailabilitiesUseCase extends BaseUseCase<CreateAvailabilitiesEntities, CreateAvailabilitiesParameters> {
  final BaseAvailabilitiesRepository baseAvailabilitiesRepository;

  UpdateAvailabilitiesUseCase(this.baseAvailabilitiesRepository);

  @override
  Future<Either<Failure, CreateAvailabilitiesEntities>> call(CreateAvailabilitiesParameters parameters)async {
    return await baseAvailabilitiesRepository.updateAvailabilities(parameters);
  }
}

