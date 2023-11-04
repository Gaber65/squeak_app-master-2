import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../../../../../../core/network/end-points.dart';
import '../../../../../../core/service/service_locator.dart';
import '../../../../../availability/domain/entities/availabilities/delete_availabilities_entities.dart';
import '../../../../domain/base_repository/base_clinic_repo.dart';
import '../../../../domain/entites/clinic/add_clinic_entities.dart';
import '../../../../domain/entites/clinic/all_clinic_follower.dart';
import '../../../../domain/entites/clinic/all_clinics_entities.dart';

import '../../../../domain/entites/clinic/follow_clinic.dart';
import '../../../../domain/entites/clinic/get_follower_clinic_entities.dart';
import '../../../../domain/entites/clinic/speciality_entities.dart';
import '../../../../domain/use_case/clinic/add_clinic_use_case.dart';
import '../../../../domain/use_case/clinic/all_clinic_supllier.dart';
import '../../../../domain/use_case/clinic/block_follow_user_use_cse.dart';
import '../../../../domain/use_case/clinic/delete_clinic_use_case.dart';
import '../../../../domain/use_case/clinic/get_all_clinic_follow.dart';
import '../../../../domain/use_case/clinic/get_all_clinics_use_case.dart';
import '../../../../domain/use_case/clinic/get_all_specialities_use_case.dart';
import '../../../../domain/use_case/clinic/get_follower_clinic_use_case.dart';
import '../../../../domain/use_case/clinic/post_follow_clinic.dart';
import '../../../../domain/use_case/clinic/post_unfollow_clinic.dart';
import '../../../../domain/use_case/clinic/update_clinic_use_case.dart';

part 'clinic_state.dart';

class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit(
    this.getAllSpecialityUseCase,
    this.addClinicUseCase,
    this.postFollowClinicUseCase,
    this.postUnFollowClinicUseCase,
    this.getAllClinicUseCase,
    this.postBlockUserFollowClinicUseCase,
    this.getAllClinicFollowUseCase,
    this.getAllSupplierClinicUseCase,
    this.updateClinicUseCase,
    this.deleteClinicUseCase,
    this.getAllFollowerClinicUseCase,
  ) : super(ClinicInitial());
  static ClinicCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }

  GetAllSpecialityUseCase getAllSpecialityUseCase;
  List<SpecialitiesData> specialitiesEntities = [];
  Future<void> getAllSpeciality() async {
    emit(GetSpecialitiesLoading());
    final result = await getAllSpecialityUseCase(const NoParameters());
    result.fold((l) {
      emit(GetSpecialitiesError(l.message));
    }, (r) {
      specialitiesEntities = r.data!;
      print(
          '*******************************$r**********************************');
      emit(GetSpecialitiesSuccess(r));
    });
  }

  String? currentAddress;
  String? currentLocation;
  String? currentCity;
  Position? currentPosition;

  Future<bool> handleLocationPermission(context) async {
    emit(GetLocationLoading());
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      emit(GetLocationSuccess());
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(GetLocationError());

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition(context) async {
    emit(GetLocationLoading());

    final hasPermission = await handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      print('${currentPosition}currentPosition');
      emit(GetLocationSuccess());

      getAddressFromLatLng(currentPosition!);
    }).catchError((e) {
      debugPrint(e);
      emit(GetLocationError());
    });
  }

  Future<void> getAddressFromLatLng(Position position) async {
    emit(GetLocationLoading());

    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = place.locality;
      currentCity = place.administrativeArea;
      currentLocation = place.locality;
      print('${currentCity}currentCity');
      print('${currentAddress}currentAddress');
      print('${currentLocation}currentLocation');
      print('${currentPosition}currentPosition');
      emit(GetLocationSuccess());
    }).catchError((e) {
      emit(GetLocationError());

      debugPrint(e);
    });
  }

  AddClinicUseCase addClinicUseCase;
  Future<void> addNewClinic({
    required String name,
    required String phone,
    required String speciality,
    required String image,
    required String code,
    required String currentLocation,
    required String currentAddress,
    required String currentCity,
  }) async {
    emit(SqueakAddNewClinicLoadingState());
    final result = await addClinicUseCase(
      AddClinicParameters(
        name: name,
        location: currentLocation!,
        city: currentCity!,
        address: currentAddress!,
        phone: phone,
        speciality: speciality,
        image: image,
        code: code,
      ),
    );
    result.fold(
      (l) => emit(
        SqueakAddNewClinicErrorState(l.message),
      ),
      (r) => emit(
        SqueakAddNewClinicSuccessState(r),
      ),
    );
    print(result.toString());
  }

  Future<void> addFireClinic({
    required String name,
    required String phone,
    required String speciality,
    required String currentLocation,
    required String currentCity,
    required String currentAddress,
  }) async {
    emit(SqueakAddNewClinicFireLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('serviceSupplier')
        .doc(uId)
        .set({
      "name": name,
      "Location": currentLocation!,
      "City": currentCity!,
      "address": currentAddress!,
      "Image": '',
      "SpecialityId": speciality,
      "phone": phone
    }).then((value) {
      emit(SqueakAddNewClinicFireSuccessState());
    }).catchError((onError) {
      emit(SqueakAddNewClinicFireErrorState());
    });
  }

  File? clinicImage;
  var picker = ImagePicker();
  Future<void> getClinicImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      clinicImage = File(pickedFile.path);
      emit(PickImageClinicSuccessState(clinicImage!));
    } else {
      debugPrint('No image selected.');
      emit(PickImageClinicErrorState());
    }
  }

  Future<void> removePostImage() async {
    clinicImage = null;
    emit(RemoveImageFile());
  }

  GetAllClinicUseCase getAllClinicUseCase;

  AllClinicEntities? allClinicEntities;
  ///todo search
  Future<void> getAllClinics({
    required String clinicName,
  }) async {
    emit(SqueakGetAllClinicLoadingState());
    final result =
        await getAllClinicUseCase(AllFollowClinicParameters(clinicName));
    result.fold(
      (l) {
        emit(SqueakGetAllClinicErrorState(l.message));
      },
      (r) {
        allClinicEntities = r;
        emit(SqueakGetAllClinicSuccessState(r));
      },
    );
    print(result.toString());
  }

  PostUnFollowClinicUseCase postUnFollowClinicUseCase;
  PostFollowClinicUseCase postFollowClinicUseCase;

  Future<void> postFollowClinics({
    required String clinicId,
  }) async {
    emit(SqueakFollowLoadingState());
    final result =
        await postFollowClinicUseCase(FollowClinicParameters(clinicId));
    result.fold(
        (l) => emit(
              SqueakFollowErrorState(l.message),
            ), (r) {
      emit(SqueakFollowSuccessState(r));
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('clinicFollow')
          .add(r.data!.toMap())
          .then((value) {
        print('sddddddddddddddddddddddddddddddddddddddddddd');
      });
    });
    print(result.toString());
  }

  Future<void> postUnFollowClinics({
    required String clinicId,
  }) async {
    emit(SqueakFollowLoadingState());
    final result =
        await postUnFollowClinicUseCase(FollowClinicParameters(clinicId));
    result.fold(
        (l) => emit(
              SqueakFollowErrorState(l.message),
            ), (r) {
      emit(
        SqueakFollowSuccessState(r),
      );
    });
    print(result.toString());
  }

  PostBlockUserFollowClinicUseCase postBlockUserFollowClinicUseCase;
  Future<void> blockFollowClinics({
    required String clinicId,
    required String userId,
  }) async {
    emit(BlockUserClinicLoading());
    final result = await postBlockUserFollowClinicUseCase(
        BlockUserClinicParameters(clinicId, userId));
    result.fold(
        (l) => emit(
              BlockUserClinicError(),
            ), (r) {
      emit(
        BlockUserClinicSuccess(),
      );
    });
    print(result.toString());
  }

  GetAllClinicFollowUseCase getAllClinicFollowUseCase;
  AllClinicFollowerEntities? allClinicFollowerEntities;
  Future<void> getAllFollowersClinics({
    required String clinicName,
  }) async {
    emit(SqueakGetAllClinicFollowerLoadingState());
    final result =
        await getAllClinicFollowUseCase(AllFollowClinicParameters(clinicName));
    result.fold(
      (l) {
        emit(SqueakGetAllClinicFollowerErrorState(l.message));
      },
      (r) {
        allClinicFollowerEntities = r;
        emit(SqueakGetAllClinicFollowerSuccessState(r));
      },
    );
    print(result.toString());
  }

  GetAllSupplierClinicUseCase getAllSupplierClinicUseCase;
  AllClinicEntities? allClinicSupplierEntities;
  Future<void> getAllSupplierClinics() async {
    emit(SqueakGetAllClinicFollowLoadingState());
    final result = await getAllSupplierClinicUseCase(AllFollowClinicParameters(
        '${sl<SharedPreferences>().getString('clintId')}'));
    result.fold(
      (l) {
        emit(SqueakGetAllClinicFollowErrorState(l.message));
      },
      (r) {
        print(
            "**************************${r.data!.clinics}}***********************");
        allClinicSupplierEntities = r;
        emit(SqueakGetAllClinicFollowSuccessState(r));
      },
    );
    print(result.toString());
  }

  UpdateClinicUseCase updateClinicUseCase;

  Future<void> updateClinic({
    required String name,
    required String phone,
    required String image,
    required String speciality,
    required String clinicId,
    required String code,
    required String currentLocation,
    required String currentCity,
    required String currentAddress,
  }) async {
    emit(UpdateClinicLoadingState());
    final result = await updateClinicUseCase(
      AddClinicParameters(
        name: name,
        location: currentLocation,
        city: currentCity,
        address: currentAddress,
        phone: phone,
        speciality: speciality,
        image: image,
        clinicId: clinicId,
        code: code,
      ),
    );
    result.fold(
      (l) => emit(UpdateClinicErrorState()),
      (r) => emit(UpdateClinicSuccessState()),
    );
  }

  DeleteClinicUseCase deleteClinicUseCase;

  DeleteAvailabilitiesEntities? deleteClinicEntities;
  Future<void> deleteClinic({
    required String clinicId,
  }) async {
    emit(DeleteClinicLoadingState());
    final result = await deleteClinicUseCase(FollowClinicParameters(clinicId));
    result.fold((l) => emit(DeleteClinicErrorState()), (r) {
      deleteClinicEntities = r;
      print(deleteClinicEntities);
      emit(DeleteClinicSuccessState());
    });
  }

  GetAllFollowerClinicUseCase getAllFollowerClinicUseCase;
  ClinicFollowersEntities? clinicFollowersEntities;
  Future<void> geMyFollowerClinic() async {
    emit(GetFollowerClinicLoadingState());
    final result = await getAllFollowerClinicUseCase(const NoParameters());
    result.fold(
      (l) {
        emit(GetFollowerClinicErrorState());
      },
      (r) {
        clinicFollowersEntities = r;
        print(
            '********************************$r*********************************');
        emit(GetFollowerSuccessState(r));
      },
    );
  }
  bool isGridView = true;
  void changeSelect() {
    isGridView =! isGridView;
    emit(ChangeStateVacState());
  }
}
