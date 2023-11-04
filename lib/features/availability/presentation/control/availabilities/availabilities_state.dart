<<<<<<< HEAD

import 'package:squeak/features/availability/domain/entities/availabilities/get_availabilities_entities.dart';
=======
part of 'availabilities_cubit.dart';
>>>>>>> cfea7653adc36927385dfeff26af1e75b2e48eb4

abstract class AvailabilitiesState {}

class AvailabilitiesInitial extends AvailabilitiesState {}

///todo Create Availabilities
class CreateAvailabilitiesLoading extends AvailabilitiesState {}
class CreateAvailabilitiesSuccess extends AvailabilitiesState {}
class CreateAvailabilitiesError extends AvailabilitiesState {}

///todo Update Availabilities
class UpdateAvailabilitiesLoading extends AvailabilitiesState {}
class UpdateAvailabilitiesSuccess extends AvailabilitiesState {}
class UpdateAvailabilitiesError extends AvailabilitiesState {}


///todo Delete Availabilities
class DeleteAvailabilitiesLoading extends AvailabilitiesState {}
class DeleteAvailabilitiesSuccess extends AvailabilitiesState {}
class DeleteAvailabilitiesError extends AvailabilitiesState {}



///todo Get Availabilities
class GetAvailabilitiesLoading extends AvailabilitiesState {}
class GetAvailabilitiesSuccess extends AvailabilitiesState {
  GetAvailabilitiesEntities availabilitiesEntities;

  GetAvailabilitiesSuccess(this.availabilitiesEntities);
}
class GetAvailabilitiesError extends AvailabilitiesState {}