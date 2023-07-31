import 'package:flutter/material.dart';
import 'package:squeak/features/setting/profile/data/model/profile_model.dart';
import 'package:squeak/features/setting/profile/domain/entities/pets_entities.dart';
import 'package:squeak/features/setting/profile/domain/entities/profile.dart';
import 'package:squeak/features/setting/profile/domain/entities/species_entities.dart';

import '../../../../setting/update_profile/domain/entities/find_pet_by_owner_id_data.dart';
import '../../../../setting/update_profile/domain/entities/update_profile.dart';
import '../../../domain/entites/add_clinic_entities.dart';
import '../../../domain/entites/all_clinics_entities.dart';

abstract class SqueakState {}

class SqueakInitialState extends SqueakState {}

class ChangeBottomNav extends SqueakState {}

class SqueakProfileDataLoadingState extends SqueakState {}

class SqueakProfileDataSuccessState extends SqueakState {
  final Profile profile;

  SqueakProfileDataSuccessState(this.profile);
}

class SqueakProfileDataErrorState extends SqueakState {
  final String error;

  SqueakProfileDataErrorState(this.error);
}

class SqueakUpdateProfileLoadingState extends SqueakState {}

class SqueakUpdateProfileSuccessState extends SqueakState {
  final UpdateProfile updateProfile;

  SqueakUpdateProfileSuccessState(this.updateProfile);
}

class SqueakUpdateProfileErrorState extends SqueakState {
  final String error;

  SqueakUpdateProfileErrorState(this.error);
}

class SqueakProfileImagePickedSuccessState extends SqueakState {}

class SqueakProfileImagePickedErrorState extends SqueakState {}

// Add Pets


class SqueakPitsImagePickedSuccessState extends SqueakState {}

class SqueakPitsImagePickedErrorState extends SqueakState {}
class AppChangeBottomSheetState extends SqueakState {}

class SqueakGetBreedLoadingState extends SqueakState {}

class SqueakGetBreedSuccessState extends SqueakState {
  final SpeciesEntities speciesEntities;

  SqueakGetBreedSuccessState(this.speciesEntities);
}

class SqueakUGetBreedErrorState extends SqueakState {
  final String error;

  SqueakUGetBreedErrorState(this.error);
}

class SqueakGetOwnerPitsLoadingState extends SqueakState {}

class SqueakGetOwnerPitsSuccessState extends SqueakState {
  final FindPetByOwnerIdData ownerPetsEntities;

  SqueakGetOwnerPitsSuccessState(this.ownerPetsEntities);
}

class SqueakUGetOwnerPitsErrorState extends SqueakState {
  final String error;

  SqueakUGetOwnerPitsErrorState(this.error);
}

class SqueakUpdatePetsLoadingState extends SqueakState {}

class SqueakUpdatePetsSuccessState extends SqueakState {
  final PetsEntities petsEntities;

  SqueakUpdatePetsSuccessState(this.petsEntities);
}

class SqueakUpdatePetsErrorState extends SqueakState {
  final String error;

  SqueakUpdatePetsErrorState(this.error);
}

class SqueakChangeExpandedRowState extends SqueakState {}

class SqueakRemovePostImageState extends SqueakState {}


class GetLocationLoading extends SqueakState {}

class GetLocationError extends SqueakState {}

class GetLocationSuccess extends SqueakState {}

class ChangeSpeciality extends SqueakState {}

class SqueakAddNewClinicLoadingState extends SqueakState {}

class SqueakAddNewClinicSuccessState extends SqueakState {
  final AddClinicEntities addClinicEntities;

  SqueakAddNewClinicSuccessState(this.addClinicEntities);
}

class SqueakAddNewClinicErrorState extends SqueakState {
  final String error;

  SqueakAddNewClinicErrorState(this.error);
}

class SqueakGetAllClinicLoadingState extends SqueakState {}

class SqueakGetAllClinicSuccessState extends SqueakState {
  final AllClinicEntities allClinicEntities;

  SqueakGetAllClinicSuccessState(this.allClinicEntities);
}

class SqueakGetAllClinicErrorState extends SqueakState {
  final String error;

  SqueakGetAllClinicErrorState(this.error);
}

class SqueakFollowLoadingState extends SqueakState {}

class SqueakFollowSuccessState extends SqueakState {
  final AllClinicEntities allClinicEntities;

  SqueakFollowSuccessState(this.allClinicEntities);
}

class SqueakFollowErrorState extends SqueakState {
  final String error;

  SqueakFollowErrorState(this.error);
}

class SqueakGetAllClinicFollowLoadingState extends SqueakState {}

class SqueakGetAllClinicFollowSuccessState extends SqueakState {
  final AllClinicEntities allClinicEntities;

  SqueakGetAllClinicFollowSuccessState(this.allClinicEntities);
}

class SqueakGetAllClinicFollowErrorState extends SqueakState {
  final String error;

  SqueakGetAllClinicFollowErrorState(this.error);
}


