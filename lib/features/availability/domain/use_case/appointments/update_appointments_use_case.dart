import 'package:dartz/dartz.dart';
import 'package:squeak/features/availability/domain/repository/base_availabilities_repository.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../entities/Appointments/update_appointments_entities.dart';
import '../../entities/appointments/update_appointments.dart';
import '../../entities/availabilities/update_av.dart';


class UpdateAppointmentsUseCase extends BaseUseCase<UpdateAppointments, CreateAppointmentsParameters> {
  final BaseAvailabilitiesRepository baseAppointmentsRepository;

  UpdateAppointmentsUseCase(this.baseAppointmentsRepository);

  @override
  Future<Either<Failure, UpdateAppointments>> call(CreateAppointmentsParameters parameters)async {
    return await baseAppointmentsRepository.updateAppointments(parameters);
  }
}

