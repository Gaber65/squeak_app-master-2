import '../../../domain/entities/find_pet_by_owner_id_data.dart';

abstract class BreedTypeStates {}

class BreedTypeInitialState extends BreedTypeStates {}

class SqueakGetOwnerPitsLoadingState extends BreedTypeStates {}

class SqueakGetOwnerPitsSuccessState extends BreedTypeStates {
  final FindPetByOwnerIdData ownerPetsEntities;
  SqueakGetOwnerPitsSuccessState(this.ownerPetsEntities);
}

class SqueakUGetOwnerPitsErrorState extends BreedTypeStates {
  final String error;
  SqueakUGetOwnerPitsErrorState(this.error);
}

class DeletePitsLoadingState extends BreedTypeStates {}

class DeletePitsSuccessState extends BreedTypeStates {}

class DeleteOwnerPitsErrorState extends BreedTypeStates {}

class AppChangeModeState extends BreedTypeStates {}

class GetAllUserPetLoadingHomePageStates extends BreedTypeStates {}
class GetAllUserPetSuccessHomePageStates extends BreedTypeStates {}
class GetAllUserPetErrorHomePageStates extends BreedTypeStates {}
