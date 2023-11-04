import 'package:dartz/dartz.dart';
<<<<<<< HEAD
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
=======

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
>>>>>>> cfea7653adc36927385dfeff26af1e75b2e48eb4
  }
}

