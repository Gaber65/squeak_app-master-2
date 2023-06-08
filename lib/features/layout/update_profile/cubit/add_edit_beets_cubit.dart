import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/service/server_error.dart';
import '../data/model/add_peets_model.dart';
import '../data/repository/beets_reprository.dart';
import 'add_edit_beets_state.dart';

class AddBeetsCubit extends Cubit<AddBeetsState> {
  AddBeetsCubit() : super(AddBeetsInitial());
  static AddBeetsCubit get(context) => BlocProvider.of(context);
  static AddBeetsCubit getobject(context) => BlocProvider.of(context);
  final authRepository = beedsRepository();
  Future AddPet({
    required String PetName,
    required String Gender,
    required String Species,
    required String Birthdate,
    required String Breedid,
    File? image,
  }) async {
    emit(AddBeetsLoadingState());
    final data = FormData();
    if (image != null) {
      final multipartImage = await MultipartFile.fromFile(image.path);
      data.files.add(
        MapEntry('Image', multipartImage),
      );
    }
    data.fields.addAll({
      MapEntry('PetName', PetName!),
      MapEntry('Gender', Gender),
      MapEntry('Species', Species),
      MapEntry('Birthdate', Birthdate!),
      MapEntry('Breedid', Breedid!),
    });
    print(data.toString());
    final response = await authRepository.AddPets(data);
    response.fold(
      (error) {
        emit(AddBeetsErrorState(error));
      },
      (response) {
        emit(AddBeetsSuccessState(response));
      },
    );
  }

  Future EditPet({
    required String PetName,
    required String Gender,
    required String petId,
    required String Species,
    required String Birthdate,
    required String Breedid,
    File? image,
  }) async {
    emit(EditPetResponseLoadingState());
    final data = FormData();
    if (image != null) {
      final multipartImage = await MultipartFile.fromFile(image.path);
      data.files.add(
        MapEntry('Image', multipartImage),
      );
    }
    data.fields.addAll({
      MapEntry('PetName', PetName!),
      MapEntry('Gender', Gender),
      MapEntry('Species', Species),
      MapEntry('Birthdate', Birthdate!),
      MapEntry('Breedid', Breedid!),
    });
    print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
    final response = await authRepository.EditPets(data, petId);
    response.fold(
      (error) {
        emit(EditPetResponseErrorState(error));
      },
      (response) {
        emit(EditPetResponseSuccessState(response));
      },
    );
  }
}
