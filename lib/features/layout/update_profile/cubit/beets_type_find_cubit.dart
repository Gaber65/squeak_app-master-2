import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/beets_reprository.dart';
import '../data/repository/update_profile_repository.dart';
import 'beets_type_find_states.dart';

class BeedstypeCubit extends Cubit<BreedTypeStates> {
  BeedstypeCubit() : super(BreedTypeInitialState());

  static BeedstypeCubit get(context) => BlocProvider.of(context);
  static BeedstypeCubit getobject(context) => BlocProvider.of(context);

  final authRepository = beedsRepository();

  Future<dynamic> speciesId(int speciesId) async {
    emit(BreedTypeLoadingState());
    final response = await authRepository.GetBeedsType(speciesId: speciesId);
    response.fold(
      (error) => emit(BreedTypeErrorState(error)),
      (ProfileResponse) {
        emit(BreedTypeSuccessState(ProfileResponse));
      },
    );
  }

  Future<dynamic> FindPetById(String petid) async {
    emit(GetPetDataLoadingState());
    final response = await authRepository.GetPetByID(petid: petid);
    response.fold(
      (error) => emit(GetPetDataErrorState(error)),
      (response) {
        print(response);
        emit(GetPetDataSuccessState(response));
      },
    );
  }

  Future<dynamic> FindPetByOwnerId() async {
    emit(BreedTypeLoadingState());
    final response = await authRepository.FindPetByOwnerId();
    response.fold(
      (error) => emit(FindPetByOwnerIdErrorState(error)),
      (response) {
        emit(FindPetByOwnerIdSuccessState(response));
      },
    );
  }
}
