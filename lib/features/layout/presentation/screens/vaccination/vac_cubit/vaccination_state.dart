part of 'vaccination_cubit.dart';

abstract class VaccinationState {}

class VaccinationInitial extends VaccinationState {}

class AppChangeBottomSheetState extends VaccinationState {}

class AppCreateDatabaseState extends VaccinationState {}

class AppCreateDatabaseLoadingState extends VaccinationState {}

class AppGetDatabaseLoadingState extends VaccinationState {}

class AppGetDatabaseState extends VaccinationState {}

class AppUpDateDatabaseState extends VaccinationState {}

class AppDeleteDatabaseState extends VaccinationState {}

class AppInsertDatabaseState extends VaccinationState {}

class ChangeSettingModeState extends VaccinationState {}

class ChangeStateVacState extends VaccinationState {}

class GetVaccinationLoadingState extends VaccinationState {}

class GetVaccinationSuccessState extends VaccinationState {
  VacEntities vacEntities;
  GetVaccinationSuccessState(this.vacEntities);
}

class GetVaccinationErrorState extends VaccinationState {
  String r;
  GetVaccinationErrorState(this.r);
}

class AddVaccinationLoadingState extends VaccinationState {}

class AddVaccinationSuccessState extends VaccinationState {
  AddNewPetData vacEntities;
  AddVaccinationSuccessState(this.vacEntities);
}

class AddVaccinationErrorState extends VaccinationState {
  String r;
  AddVaccinationErrorState(this.r);
}

class GetVaccinationFireLoadingState extends VaccinationState {}

class GetVaccinationFireSuccessState extends VaccinationState {}

class GetVaccinationFireErrorState extends VaccinationState {}
