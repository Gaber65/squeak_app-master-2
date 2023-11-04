import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../entities/Appointments/update_appointments_entities.dart';
import '../../repository/base_availabilities_repository.dart';


class CreateAppointmentsUseCase extends BaseUseCase<CreateAppointmentsEntities, CreateAppointmentsParameters> {
  final BaseAvailabilitiesRepository baseAppointmentsRepository;

  CreateAppointmentsUseCase(this.baseAppointmentsRepository);

  @override
  Future<Either<Failure, CreateAppointmentsEntities>> call(CreateAppointmentsParameters parameters)async {
    return await baseAppointmentsRepository.createAppointments(parameters);
  }
}

