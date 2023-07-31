import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squeak/core/network/dio_helper.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import 'package:squeak/features/layout/presentation/controller/cubit/squeak_state.dart';
import 'package:squeak/features/setting/profile/domain/entities/profile.dart';
import 'package:squeak/features/setting/profile/domain/usecase/get_breeds_use_case.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/get_owner_pets.dart';
import 'package:squeak/features/setting/profile/domain/usecase/get_profile_user_use_case.dart';
import 'package:squeak/features/setting/profile/presentation/pages/profile.dart';

import '../../../../setting/profile/domain/entities/pets_entities.dart';
import '../../../../setting/profile/domain/entities/species_entities.dart';

import '../../../../setting/update_profile/domain/entities/find_pet_by_owner_id_data.dart';
import '../../../../setting/update_profile/domain/entities/update_profile.dart';
import '../../../../setting/update_profile/domain/repository/base_update_profile_repository.dart';
import '../../../../setting/update_profile/domain/usecase/get_update_profile_use_case.dart';
import '../../../../setting/update_profile/domain/usecase/post_pets_use_case.dart';
import '../../../../setting/update_profile/domain/usecase/update_pits_use_case.dart';
import '../../../domain/base_repository/base_clinic_repo.dart';
import '../../../domain/entites/add_clinic_entities.dart';
import '../../../domain/entites/all_clinics_entities.dart';
import '../../../domain/use_case/clinic/add_clinic_use_case.dart';
import '../../../domain/use_case/clinic/get_all_clinic_follow.dart';
import '../../../domain/use_case/clinic/get_all_clinics_use_case.dart';
import '../../../domain/use_case/clinic/post_follow_clinic.dart';
import '../../../domain/use_case/clinic/post_unfollow_clinic.dart';
import '../../screens/home/home.dart';
import '../../screens/nav/nav.dart';
import '../../screens/time/time.dart';

class SqueakCubit extends Cubit<SqueakState> {
  SqueakCubit(
    this.getProfileUseData,
    this.getUpdateProfileUseCase,
    this.postPetsUseCase,
    this.getOwnerPetsUseCase,
    this.updatePetsUseCase,
    this.addClinicUseCase,
    this.getAllClinicUseCase,
    this.postFollowClinicUseCase,
    this.postUnFollowClinicUseCase,
    this.getAllClinicFollowUseCase,
  ) : super(SqueakInitialState());

  final GetProfileUseCase getProfileUseData;
  final GetUpdateProfileUseCase getUpdateProfileUseCase;


  static SqueakCubit get(context) => BlocProvider.of(context);

  // change bottom navigation
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
        size: AppSize.s30,
      ),
      label: '',
    ),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.watch_later_outlined,
          size: AppSize.s30,
        ),
        label: ''),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.gps_fixed_outlined,
          size: AppSize.s30,
        ),
        label: ''),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          size: AppSize.s30,
        ),
        label: ''),
  ];
  List<Widget> screens = [
    HomeScreen(),
    const TimeScreen(),
    const AppointmentsPage(),
    const ProfileScreen(),
  ];

  bool isShow = false;
  void changeExpandedRow() {
    isShow = !isShow;
    emit(SqueakChangeExpandedRowState());
  }

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }


  Profile? profile;
  Future<void> getProfile() async {
    emit(SqueakProfileDataLoadingState());

    final result = await getProfileUseData(const NoParameters());
    result.fold(
      (l) {
        emit(SqueakProfileDataErrorState(l.message));
      },
      (r) {
        profile = r;
        emit(SqueakProfileDataSuccessState(r));
      },
    );
  }

  final GetOwnerPetsUseCase getOwnerPetsUseCase;
  late FindPetByOwnerIdData ownerPetsEntities;
  Future<void> getOwnerPits() async {
    emit(SqueakGetOwnerPitsLoadingState());
    final result = await getOwnerPetsUseCase(const NoParameters());
    result.fold(
      (l) {
        emit(SqueakUGetOwnerPitsErrorState(l.message));
      },
      (r) {
        ownerPetsEntities = r;
        emit(SqueakGetOwnerPitsSuccessState(r));
      },
    );
  }

  Future<dynamic> getUpdateProfile({
    required String fullName,
    required String phone,
    required String imageName,
    required String address,
    required int gender,
    required String birthdate,
    required int userType,
    required String userName,
  }) async {
    emit(SqueakUpdateProfileLoadingState());

    final result = await getUpdateProfileUseCase(
      UpdateProfileParameters(
        fullName: fullName,
        imageName: imageName,
        address: address,
        birthDate: birthdate,
        phoneNumber: phone,
        userType: userType,
        gender: gender,
        userName: userName,
      ),
    );
    result.fold(
      (l) {
        emit(SqueakUpdateProfileErrorState(l.message));
      },
      (r) {
        emit(SqueakUpdateProfileSuccessState(r));
      },
    );
    
    
    FirebaseFirestore.instance.collection('users').doc(uId).set({
      'fullName': fullName,
      'imageName': imageName,
      'gender': gender,
      'address': address,
      'birthdate': birthdate,
      'phone': phone,
      'userType': userType,
      'userName': userName,
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<dynamic> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage);
      emit(SqueakProfileImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SqueakProfileImagePickedErrorState());
    }
  }

  final PostPetsUseCase postPetsUseCase;
  late PetsEntities petsEntities;

  File? pitsImage;
  Future<void> getPitsImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pitsImage = File(pickedFile.path);
      emit(SqueakPitsImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SqueakPitsImagePickedErrorState());
    }
  }



  File? updatePitsImage;
  Future<void> getUpdatePitsImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      updatePitsImage = File(pickedFile.path);
      emit(SqueakPitsImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SqueakPitsImagePickedErrorState());
    }
  }

  SpeciesEntities? updateSpeciesEntities;
  UpdatePetsUseCase updatePetsUseCase;

  void removePostImage() async {
    postImage = null;
    postVideo = null;
    postCamera = null;
    emit(SqueakRemovePostImageState());
  }

  File? postImage;
  File? postVideo;
  File? postCamera;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SqueakPitsImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SqueakPitsImagePickedErrorState());
    }
  }

  Future<void> getPostVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      emit(SqueakPitsImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SqueakPitsImagePickedErrorState());
    }
  }

  Future<void> getPostCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      postCamera = File(pickedFile.path);
      emit(SqueakPitsImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SqueakPitsImagePickedErrorState());
    }
  }

  bool isButtonSheetShown = false;

  void changeBottomSheetShow({
    required bool isShow,
  }) {
    isButtonSheetShown = isShow;
    emit(AppChangeBottomSheetState());
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
      currentLocation = place.subAdministrativeArea;
      print('${currentCity}currentCity');
      print('${currentAddress}currentAddress');
      print('${currentLocation}currentLocation');
      emit(GetLocationSuccess());
    }).catchError((e) {
      emit(GetLocationError());

      debugPrint(e);
    });
  }

  int selectID = 1;
  void changeSpeciality(int id) {
    selectID = id;
    emit(ChangeSpeciality());
  }

  AddClinicEntities? addClinicEntities;
  AddClinicUseCase addClinicUseCase;
  Future<void> addNewClinic({
    required String name,
    required String phone,
    required String speciality,
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
        adminId: clintId ?? '38DDCBC2-7B2C-48FE-FF6F-08DB6F35167F',
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

  List<AllClinicEntities> allClinicEntities = [];
  GetAllClinicUseCase getAllClinicUseCase;

  Future<void> getAllClinics() async {
    emit(SqueakGetAllClinicLoadingState());
    final result = await getAllClinicUseCase(const NoParameters());
    result.fold(
        (l) => emit(
              SqueakGetAllClinicErrorState(l.message),
            ), (r) {
      emit(
        SqueakGetAllClinicSuccessState(r),
      );
      r = allClinicEntities as AllClinicEntities;
    });
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
      emit(
        SqueakFollowSuccessState(r),
      );
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

  List<AllClinicEntities> followClinic = [];
  GetAllClinicFollowUseCase getAllClinicFollowUseCase;
  Future<void> getAllFollowClinics({required String adminId}) async {
    emit(SqueakGetAllClinicFollowLoadingState());
    final result =
        await getAllClinicFollowUseCase(AllFollowClinicParameters(adminId));
    result.fold(
        (l) => emit(
              SqueakGetAllClinicErrorState(l.message),
            ), (r) {
      emit(
        SqueakGetAllClinicFollowSuccessState(r),
      );
      r = followClinic as AllClinicEntities;
    });
    print(result.toString());
  }
}
