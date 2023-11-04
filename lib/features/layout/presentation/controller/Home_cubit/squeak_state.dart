import 'dart:io';


import 'package:squeak/features/setting/profile/domain/entities/profile.dart';

import '../../../../setting/update_profile/domain/entities/find_pet_by_owner_id_data.dart';
import '../../../../setting/update_profile/domain/entities/update_profile.dart';


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

class SqueakProfileImagePickedSuccessState extends SqueakState {
  File file;

  SqueakProfileImagePickedSuccessState(this.file);
}

class SqueakProfileImagePickedErrorState extends SqueakState {}

// Add Pets




class SqueakGetOwnerPitsLoadingState extends SqueakState {}
class ChangeStateVacState extends SqueakState {}

class SqueakGetOwnerPitsSuccessState extends SqueakState {
  final FindPetByOwnerIdData ownerPetsEntities;

  SqueakGetOwnerPitsSuccessState(this.ownerPetsEntities);
}

class SqueakUGetOwnerPitsErrorState extends SqueakState {
  final String error;

  SqueakUGetOwnerPitsErrorState(this.error);
}


