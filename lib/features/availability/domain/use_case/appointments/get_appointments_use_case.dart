import 'package:dartz/dartz.dart';
<<<<<<< HEAD
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
=======

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
>>>>>>> cfea7653adc36927385dfeff26af1e75b2e48eb4
  }
}

