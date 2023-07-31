part of 'vaccination_cubit.dart';

abstract class VaccinationState {}

class VaccinationInitial extends VaccinationState {}

class AppChangeBottomSheetState extends VaccinationState {}

class AppCreateDatabaseState extends VaccinationState {}

class AppGetDatabaseLoadingState extends VaccinationState {}

class AppGetDatabaseState extends VaccinationState {}

class AppUpDateDatabaseState extends VaccinationState {}

class AppDeleteDatabaseState extends VaccinationState {}

class AppInsertDatabaseState extends VaccinationState {}
