import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../entities/availabilities/update_av.dart';
import '../../repository/base_availabilities_repository.dart';


class UpdateAvailabilitiesUseCase extends BaseUseCase<UpdateAvailabilities, CreateAvailabilitiesParameters> {
  final BaseAvailabilitiesRepository baseAvailabilitiesRepository;

  UpdateAvailabilitiesUseCase(this.baseAvailabilitiesRepository);

  @override
  Future<Either<Failure, UpdateAvailabilities>> call(CreateAvailabilitiesParameters parameters)async {
    return await baseAvailabilitiesRepository.updateAvailabilities(parameters);
  }
}

