import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/get_owner_pets.dart';

import '../../../../../../core/service/service_locator.dart';

import '../../../../../../core/usecase/base_usecase.dart';
import '../../../domain/entities/find_pet_by_owner_id_data.dart';
import '../../../domain/usecase/delete_pet_use_case.dart';
import 'beets_type_find_states.dart';

class BreedsTypeCubit extends Cubit<BreedTypeStates> {
  BreedsTypeCubit(this.getOwnerPetsUseCase, this.deletePetsUseCase)
      : super(BreedTypeInitialState());

  static BreedsTypeCubit get(context) => BlocProvider.of(context);

  final GetOwnerPetsUseCase getOwnerPetsUseCase;

  Future<void> getOwnerPits() async {
    emit(SqueakGetOwnerPitsLoadingState());
    final result = await getOwnerPetsUseCase(const NoParameters());
    result.fold(
      (l) {
        emit(SqueakUGetOwnerPitsErrorState(l.message));
      },
      (r) {
        emit(SqueakGetOwnerPitsSuccessState(r));
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

  String? language;
  void changeAppLang({
    String? fromSharedLang,
    String? langMode,
  }) {
    if (fromSharedLang != null) {
      language = fromSharedLang;
      emit(AppChangeModeState());
    } else {
      language = langMode;
      sl<SharedPreferences>()
          .setString(
        'language',
        langMode!,
      )
          .then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  DeletePetsUseCase deletePetsUseCase;
  Future<void> deletePet({required String petId}) async {
    emit(DeletePitsLoadingState());
    final result = await deletePetsUseCase(
      DeletePetParameters(petId: petId),
    );

    result.fold((l) => {emit(DeleteOwnerPitsErrorState())},
        (r) => {emit(DeletePitsSuccessState())});
  }
}
