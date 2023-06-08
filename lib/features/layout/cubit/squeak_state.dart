import 'package:flutter/material.dart';
import 'package:squeak/features/layout/profile/data/model/profile_model.dart';
import 'package:squeak/features/layout/profile/domain/entities/pets_entities.dart';
import 'package:squeak/features/layout/profile/domain/entities/profile.dart';
import 'package:squeak/features/layout/profile/domain/entities/species_entities.dart';
import 'package:squeak/features/layout/update_profile/domain/entities/update_profile.dart';

import '../profile/domain/entities/owner_pets.dart';

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
class SqueakAddPetsLoadingState extends SqueakState {}

class SqueakAddPetsSuccessState extends SqueakState {
  final PetsEntities petsEntities;

  SqueakAddPetsSuccessState(this.petsEntities);
}

class SqueakUAddPetsErrorState extends SqueakState {
  final String error;

  SqueakUAddPetsErrorState(this.error);
}

class SqueakPitsImagePickedSuccessState extends SqueakState {}

class SqueakPitsImagePickedErrorState extends SqueakState {}

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
  final OwnerPetsEntities ownerPetsEntities;

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

class SqueakChangeExpandedRowState extends SqueakState{}

class SqueakRemovePostImageState extends SqueakState{}

class AppChangeBottomSheetState extends SqueakState{}


class AppCreateDatabaseState extends SqueakState {}

class AppGetDatabaseLoadingState extends SqueakState {}

class AppGetDatabaseState extends SqueakState {}
class AppUpDateDatabaseState extends SqueakState {}
class AppDeleteDatabaseState extends SqueakState {}

class AppInsertDatabaseState extends SqueakState {}