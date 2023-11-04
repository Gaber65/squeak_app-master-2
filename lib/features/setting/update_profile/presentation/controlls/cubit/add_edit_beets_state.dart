import 'dart:io';

import 'package:flutter/material.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/beeds_type_data.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';

import '../../../domain/entities/add_peets_data.dart';
import '../../../domain/entities/edit_pets_data.dart';

@immutable
abstract class AddBeetsState {}

class AddBeetsInitial extends AddBeetsState {}

class GetAllSpeciesLoadingState extends AddBeetsState {}

class GetAllSpeciesSuccessState extends AddBeetsState {
  SpeciesEntities speciesEntities;

  GetAllSpeciesSuccessState(this.speciesEntities);
}

class GetAllSpeciesErrorState extends AddBeetsState {
  final String error;
  GetAllSpeciesErrorState(this.error);
}

class GetBreedBySpeciesIdLoadingState extends AddBeetsState {}

class GetBreedBySpeciesIdSuccessState extends AddBeetsState {
  BreedEntities breedEntities;

  GetBreedBySpeciesIdSuccessState(this.breedEntities);
}

class GetBreedBySpeciesIdErrorState extends AddBeetsState {
  final String error;
  GetBreedBySpeciesIdErrorState(this.error);
}

class SqueakPitsImagePickedSuccessState extends AddBeetsState {
  File file;
  SqueakPitsImagePickedSuccessState(this.file);

}

class SqueakPitsImagePickedErrorState extends AddBeetsState {}

class SqueakAddPetsLoadingState extends AddBeetsState {}

class SqueakAddPetsSuccessState extends AddBeetsState {
  final AddNewPetData addNewPetData;

  SqueakAddPetsSuccessState(this.addNewPetData);
}

class SqueakUAddPetsErrorState extends AddBeetsState {
  final String error;

  SqueakUAddPetsErrorState(this.error);
}


class SqueakEditPetsLoadingState extends AddBeetsState {}

class SqueakEditPetsSuccessState extends AddBeetsState {
  final AddNewPetData addNewPetData;

  SqueakEditPetsSuccessState(this.addNewPetData);
}

class SqueakEditPetsErrorState extends AddBeetsState {
  final String error;

  SqueakEditPetsErrorState(this.error);
}


class SqueakAddPetsFireLoadingState extends AddBeetsState {}
class SqueakAddPetsFireSuccessState extends AddBeetsState {}
class SqueakUAddPetsFireErrorState extends AddBeetsState {}