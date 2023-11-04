import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
<<<<<<< HEAD
import '../../entities/Appointments/update_appointments_entities.dart';
import '../../repository/base_availabilities_repository.dart';


class CreateAppointmentsUseCase extends BaseUseCase<CreateAppointmentsEntities, CreateAppointmentsParameters> {
  final BaseAvailabilitiesRepository baseAppointmentsRepository;

  CreateAppointmentsUseCase(this.baseAppointmentsRepository);

  @override
  Future<Either<Failure, CreateAppointmentsEntities>> call(CreateAppointmentsParameters parameters)async {
    return await baseAppointmentsRepository.createAppointments(parameters);
=======
import '../../entities/availabilities/create_availabilities_entities.dart';
import '../../repository/base_availabilities_repository.dart';


class CreateAvailabilitiesUseCase extends BaseUseCase<CreateAvailabilitiesEntities, CreateAvailabilitiesParameters> {
  final BaseAvailabilitiesRepository baseAvailabilitiesRepository;

  CreateAvailabilitiesUseCase(this.baseAvailabilitiesRepository);

  @override
  Future<Either<Failure, CreateAvailabilitiesEntities>> call(CreateAvailabilitiesParameters parameters)async {
    return await baseAvailabilitiesRepository.createAvailabilities(parameters);
>>>>>>> cfea7653adc36927385dfeff26af1e75b2e48eb4
  }
}

