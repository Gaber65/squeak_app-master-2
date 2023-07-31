

import '../../../../core/service/server_error.dart';
import '../data/model/add_peets_model.dart';
import '../data/model/beeds_type_model.dart';
import '../domain/entities/beeds_type_data.dart';
import '../domain/entities/find_pet_by_owner_id_data.dart';

abstract class BreedTypeStates {}

class BreedTypeInitialState extends BreedTypeStates {}
class BreedTypeLoadingState extends BreedTypeStates {}

class BreedTypeSuccessState extends BreedTypeStates {
  final BreedTypeData response;

  BreedTypeSuccessState(this.response);
}

class BreedTypeErrorState extends BreedTypeStates {
  final ServerError error;

  BreedTypeErrorState(this.error);
}
class FindPetByOwnerIdInitialState extends BreedTypeStates {}
class FindPetByOwnerIdLoadingState extends BreedTypeStates {}

class FindPetByOwnerIdSuccessState extends BreedTypeStates {
  final FindPetByOwnerIdData response;

  FindPetByOwnerIdSuccessState(this.response);
}

class FindPetByOwnerIdErrorState extends BreedTypeStates {
  final ServerError error;

  FindPetByOwnerIdErrorState(this.error);




}


class GetPetDataInitial extends BreedTypeStates {}
class GetPetDataLoadingState extends BreedTypeStates {}


class GetPetDataSuccessState extends BreedTypeStates {
  final FindPetByOwnerIdData response;


  GetPetDataSuccessState(this.response);
}

class GetPetDataErrorState extends BreedTypeStates {
  final ServerError error;

  GetPetDataErrorState(this.error);}



class AppChangeModeState extends BreedTypeStates {}
