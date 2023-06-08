

import 'package:flutter/material.dart';

import '../../../../core/service/server_error.dart';
import '../data/model/add_peets_model.dart';
import '../data/model/edit_pets_model.dart';
import '../domain/entities/add_peets_data.dart';
import '../domain/entities/edit_pets_data.dart';

@immutable
abstract class AddBeetsState {}

class AddBeetsInitial extends AddBeetsState {}
class AddBeetsLoadingState extends AddBeetsState {}

class AddBeetsSuccessState extends AddBeetsState {
  final AddNewPetData response;

  AddBeetsSuccessState(this.response);
}

class AddBeetsErrorState extends AddBeetsState {
  final ServerError error;

  AddBeetsErrorState(this.error);}
class EditPetResponseLoadingState extends AddBeetsState {}

class EditPetResponseSuccessState extends AddBeetsState {
  final EditPetData response;

  EditPetResponseSuccessState(this.response);
}

class EditPetResponseErrorState extends AddBeetsState {
  final ServerError error;

  EditPetResponseErrorState(this.error);}