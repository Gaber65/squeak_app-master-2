import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';
import 'package:squeak/features/setting/update_profile/domain/repository/base_update_profile_repository.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/get_all_species_use_cse.dart';
import 'package:video_player/video_player.dart';
import '../../../../../../core/service/service_locator.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../../domain/entities/add_peets_data.dart';
import '../../../domain/entities/beeds_type_data.dart';
import '../../../domain/usecase/get_breed_by_speciesId_use_case.dart';
import '../../../domain/usecase/post_pets_use_case.dart';
import '../../../domain/usecase/update_pits_use_case.dart';
import 'add_edit_beets_state.dart';
import 'beets_type_find_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddBeetsCubit extends Cubit<AddBeetsState> {
  AddBeetsCubit(
    this.getAllSpeciesUseCase,
    this.getBreedBySpeciesIdUseCase,
    this.postPetsUseCase,
    this.updatePetsUseCase,
  ) : super(AddBeetsInitial());
  static AddBeetsCubit get(context) => BlocProvider.of(context);

  GetAllSpeciesUseCase getAllSpeciesUseCase;
  SpeciesEntities? speciesEntities;

  Future getAllSpecies() async {
    emit(GetAllSpeciesLoadingState());
    final result = await getAllSpeciesUseCase(const NoParameters());

    result.fold(
      (l) {
        emit(GetAllSpeciesErrorState(l.message));
      },
      (r) {
        speciesEntities = r;
        emit(GetAllSpeciesSuccessState(r));
      },
    );
  }

  GetBreedBySpeciesIdUseCase getBreedBySpeciesIdUseCase;
  BreedEntities? breedSpecies;
  Future<void> getBreedBySpeciesId({required String speciesId}) async {
    emit(GetBreedBySpeciesIdLoadingState());
    final result = await getBreedBySpeciesIdUseCase(
        GetBreedBySpeciesIdParameters(speciesId: speciesId));
    result.fold(
      (l) {
        emit(GetBreedBySpeciesIdErrorState(l.message));
      },
      (r) {
        breedSpecies = r;
        print(r);

        emit(GetBreedBySpeciesIdSuccessState(r));
      },
    );
  }

  File? pitsImage;
  var picker = ImagePicker();
  Future<void> getPitsImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pitsImage = File(pickedFile.path);
      emit(SqueakPitsImagePickedSuccessState(pitsImage!));
    } else {
      debugPrint('No image selected.');
      emit(SqueakPitsImagePickedErrorState());
    }
  }

  Future<void> pickMedia() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    final XFile? pickedVideo =
        await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Handle the image file
      // You can display it using the 'pickedImage.path' or 'pickedImage.readAsBytes()'
    }

    if (pickedVideo != null) {
      // Handle the video file
      // You can display it using the 'VideoPlayer' widget from the video_player package
      VideoPlayerController _controller =
          VideoPlayerController.file(File(pickedVideo.path));
      await _controller.initialize();
      // You can display the video by adding a VideoPlayer widget and passing '_controller' as the controller.
    }
  }

  late AddNewPetData addNewPetData;
  PostPetsUseCase postPetsUseCase;
  var formKey = GlobalKey<FormState>();

  Future<void> addPets({
    required String petName,
    required int gender,
    required String birthdate,
    required String breedId,
    required String image,
  }) async {
    emit(SqueakAddPetsLoadingState());

    final result = await postPetsUseCase(
      PostPetsParameters(
        petName: petName,
        gender: gender,
        birthdate: birthdate,
        imageName: image,
        ownerClientId: sl<SharedPreferences>().getString('clintId')!,
        breedId: breedId,
      ),
    );

    result.fold((l) {
      emit(SqueakUAddPetsErrorState(l.message));
    }, (r) {
      emit(SqueakAddPetsSuccessState(r));
    });
  }

  Future<void> addPetsFire({
    required String petName,
    required int gender,
    required String birthdate,
    required String breedId,
  }) async {
    emit(SqueakAddPetsFireLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('PetImage/${Uri.file(pitsImage!.path).pathSegments.last}')
        .putFile(pitsImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .collection('pet')
            .doc()
            .set({
          'petName': petName,
          'gender': gender,
          'birthdate': birthdate,
          'imageName': value,
          'ownerClientId': sl<SharedPreferences>().getString('clintId')!,
          'breedId': breedId!,
        }).then((value) {
          emit(SqueakAddPetsFireSuccessState());
        }).catchError((onError) {
          emit(SqueakUAddPetsFireErrorState());
        });
      }).catchError((error) {
        emit(SqueakUAddPetsFireErrorState());
      });
    }).catchError((error) {
      emit(SqueakUAddPetsFireErrorState());
    });


  }

  UpdatePetsUseCase updatePetsUseCase;

  Future<void> editPets({
    required String petName,
    required int gender,
    required String birthdate,
    required String breedId,
    required String petId,
    required String image,
  }) async {
    emit(SqueakEditPetsLoadingState());

    final result = await updatePetsUseCase(
      UpdatePetsParameters(
        petName: petName,
        gender: gender,
        birthdate: birthdate,
        image: image,
        ownerClientId: sl<SharedPreferences>().getString('clintId')!,
        breedId: breedId,
        petId: petId,
      ),
    );

    result.fold((l) {
      emit(SqueakEditPetsErrorState(l.message));
    }, (r) {
      emit(SqueakEditPetsSuccessState(r));
    });
  }
}
