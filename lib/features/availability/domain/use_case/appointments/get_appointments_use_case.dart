import 'package:dartz/dartz.dart';
import 'package:squeak/features/availability/domain/repository/base_availabilities_repository.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../entities/Appointments/get_Appointments_entities.dart';


class GetAppointmentsUseCase extends BaseUseCase<GetAppointmentsEntities, NoParameters> {
  final BaseAvailabilitiesRepository baseAppointmentsRepository;

  GetAppointmentsUseCase(this.baseAppointmentsRepository);

  @override
  Future<Either<Failure, GetAppointmentsEntities>> call(NoParameters parameters)async {
    return await baseAppointmentsRepository.getAppointments();
  }
}

