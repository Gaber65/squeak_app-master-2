import 'package:dartz/dartz.dart';
import 'package:squeak/features/availability/domain/repository/base_availabilities_repository.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../entities/Appointments/delete_Appointments_entities.dart';


class DeleteAppointmentsUseCase extends BaseUseCase<DeleteAppointmentsEntities, DeleteAppointmentsParameters> {
  final BaseAvailabilitiesRepository baseAppointmentsRepository;

  DeleteAppointmentsUseCase(this.baseAppointmentsRepository);

  @override
  Future<Either<Failure, DeleteAppointmentsEntities>> call(DeleteAppointmentsParameters parameters)async {
    return await baseAppointmentsRepository.deleteAppointments(parameters);
  }
}

