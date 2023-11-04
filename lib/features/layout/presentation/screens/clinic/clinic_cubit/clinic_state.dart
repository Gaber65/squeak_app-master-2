part of 'clinic_cubit.dart';

abstract class ClinicState {}

class ClinicInitial extends ClinicState {}
class ChangeBottomNav extends ClinicState {}

class GetSpecialitiesLoading extends ClinicState {}

class GetSpecialitiesSuccess extends ClinicState {
  SpecialitiesEntities specialitiesEntities;

  GetSpecialitiesSuccess(this.specialitiesEntities);
}

class GetSpecialitiesError extends ClinicState {
  String l;
  GetSpecialitiesError(this.l);
}

// SpecialitiesEntities
class GetLocationLoading extends ClinicState {}

class GetLocationError extends ClinicState {}

class GetLocationSuccess extends ClinicState {}

class ChangeSpeciality extends ClinicState {}

class SqueakAddNewClinicLoadingState extends ClinicState {}

class SqueakAddNewClinicSuccessState extends ClinicState {
  final AddClinicEntities addClinicEntities;
  SqueakAddNewClinicSuccessState(this.addClinicEntities);
}

class SqueakAddNewClinicErrorState extends ClinicState {
  final String error;

  SqueakAddNewClinicErrorState(this.error);
}

class SqueakAddNewClinicFireLoadingState extends ClinicState {}

class SqueakAddNewClinicFireSuccessState extends ClinicState {}

class SqueakAddNewClinicFireErrorState extends ClinicState {}

class PickImageClinicErrorState extends ClinicState {}

class PickImageClinicSuccessState extends ClinicState {
  File path;

  PickImageClinicSuccessState(this.path);
}

class RemoveImageFile extends ClinicState {}

class SqueakGetAllClinicLoadingState extends ClinicState {}

class SqueakGetAllClinicSuccessState extends ClinicState {
  final AllClinicEntities allClinicEntities;

  SqueakGetAllClinicSuccessState(this.allClinicEntities);
}

class SqueakGetAllClinicErrorState extends ClinicState {
  final String error;

  SqueakGetAllClinicErrorState(this.error);
}

class SqueakGetAllClinicFollowerLoadingState extends ClinicState {}

class SqueakGetAllClinicFollowerSuccessState extends ClinicState {
  final AllClinicFollowerEntities allClinicFollowerEntities;

  SqueakGetAllClinicFollowerSuccessState(this.allClinicFollowerEntities);
}

class SqueakGetAllClinicFollowerErrorState extends ClinicState {
  final String error;

  SqueakGetAllClinicFollowerErrorState(this.error);
}


class SqueakFollowLoadingState extends ClinicState {}

class SqueakFollowSuccessState extends ClinicState {
  final FollowEntites allClinicEntities;

  SqueakFollowSuccessState(this.allClinicEntities);
}

class SqueakFollowErrorState extends ClinicState {
  final String error;

  SqueakFollowErrorState(this.error);
}

class SqueakGetAllClinicFollowLoadingState extends ClinicState {}

class SqueakGetAllClinicFollowSuccessState extends ClinicState {
  final AllClinicEntities allClinicEntities;

  SqueakGetAllClinicFollowSuccessState(this.allClinicEntities);
}

class SqueakGetAllClinicFollowErrorState extends ClinicState {
  final String error;

  SqueakGetAllClinicFollowErrorState(this.error);
}

class UpdateClinicLoadingState extends ClinicState {}
class UpdateClinicSuccessState extends ClinicState {}
class UpdateClinicErrorState extends ClinicState {}


class DeleteClinicLoadingState extends ClinicState {}
class DeleteClinicSuccessState extends ClinicState {}
class DeleteClinicErrorState extends ClinicState {}


class BlockUserClinicLoading extends ClinicState {}
class BlockUserClinicSuccess extends ClinicState {}
class BlockUserClinicError extends ClinicState {}




class GetFollowerClinicLoadingState extends ClinicState {}
class GetFollowerSuccessState extends ClinicState {
  ClinicFollowersEntities clinicFollowersEntities;

  GetFollowerSuccessState(this.clinicFollowersEntities);
}
class GetFollowerClinicErrorState extends ClinicState {}
class ChangeStateVacState extends ClinicState {}