import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../entities/availabilities/create_availabilities_entities.dart';
import '../../repository/base_availabilities_repository.dart';


class CreateAvailabilitiesUseCase extends BaseUseCase<CreateAvailabilitiesEntities, CreateAvailabilitiesParameters> {
  final BaseAvailabilitiesRepository baseAvailabilitiesRepository;

  CreateAvailabilitiesUseCase(this.baseAvailabilitiesRepository);

  @override
  Future<Either<Failure, CreateAvailabilitiesEntities>> call(CreateAvailabilitiesParameters parameters)async {
    return await baseAvailabilitiesRepository.createAvailabilities(parameters);
  }
}

