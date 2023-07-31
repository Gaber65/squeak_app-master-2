import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../entities/availabilities/get_availabilities_entities.dart';
import '../../repository/base_availabilities_repository.dart';


class GetAvailabilitiesUseCase extends BaseUseCase<GetAvailabilitiesEntities, GetAvailabilitiesParameters> {
  final BaseAvailabilitiesRepository baseAvailabilitiesRepository;

  GetAvailabilitiesUseCase(this.baseAvailabilitiesRepository);

  @override
  Future<Either<Failure, GetAvailabilitiesEntities>> call(GetAvailabilitiesParameters parameters)async {
    return await baseAvailabilitiesRepository.getAvailabilities(parameters);
  }
}

