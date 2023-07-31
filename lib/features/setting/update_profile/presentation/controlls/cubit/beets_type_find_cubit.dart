import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/end-points.dart';

import '../../../../core/service/service_locator.dart';
import '../data/repository/beets_reprository.dart';
import '../data/repository/update_profile_repository.dart';
import 'beets_type_find_states.dart';

class BeedsTypeCubit extends Cubit<BreedTypeStates> {
  BeedsTypeCubit() : super(BreedTypeInitialState());

  static BeedsTypeCubit get(context) => BlocProvider.of(context);
  static BeedsTypeCubit getobject(context) => BlocProvider.of(context);

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
        print(response.data);
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
        print(response.data);
      },
    );
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      sl<SharedPreferences>()
          .setBool(
        'isDark',
        isDark,
      )
          .then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  void changeAppLang({required String fromSharedLang}) {
    if (fromSharedLang != null) {
      language = fromSharedLang;
      emit(AppChangeModeState());
    } else {
      language != language;
      sl<SharedPreferences>()
          .setString(
        'language',
        language,
      )
          .then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
