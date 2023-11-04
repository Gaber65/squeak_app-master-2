import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_state.dart';
import 'package:squeak/features/setting/profile/domain/entities/profile.dart';
import 'package:squeak/features/setting/update_profile/domain/usecase/get_owner_pets.dart';
import 'package:squeak/features/setting/profile/domain/usecase/get_profile_user_use_case.dart';
import 'package:squeak/features/setting/profile/presentation/pages/profile.dart';

import '../../../../setting/update_profile/domain/entities/find_pet_by_owner_id_data.dart';
import '../../../../setting/update_profile/domain/repository/base_update_profile_repository.dart';
import '../../../../setting/update_profile/domain/usecase/get_update_profile_use_case.dart';

import '../../screens/home/home.dart';
import '../../../../availability/presentation/page/appointments/get_appointments.dart';
import '../../screens/time/Follower_user_supplier.dart';

class SqueakCubit extends Cubit<SqueakState> {
  SqueakCubit(
    this.getProfileUseData,
    this.getUpdateProfileUseCase,
    this.getOwnerPetsUseCase,
  ) : super(SqueakInitialState());

  final GetProfileUseCase getProfileUseData;
  final GetUpdateProfileUseCase getUpdateProfileUseCase;

  static SqueakCubit get(context) => BlocProvider.of(context);

  // change bottom navigation
  List<Tab> items = [
    const Tab(
      icon: Icon(
        IconlyLight.home,
      ),
    ),
    const Tab(
      icon: Icon(
        IconlyLight.add_user,
      ),
    ),
    const Tab(
      icon: Icon(
        IconlyLight.time_circle,
      ),
    ),
    const Tab(
      icon: Icon(
        IconlyLight.setting,
      ),
    ),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const FollowerScreen(),
    const AppointmentsPage(),
    const ProfileScreen(),
  ];

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
  FindPetByOwnerIdData? ownerPetsEntities;
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
    required String email,
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

    FirebaseFirestore.instance.collection('users').doc(uId).update({
      'fullName': fullName,
      'image': imageName,
      'gender': gender,
      'address': address,
      'birthdate': birthdate,
      'phone': phone,
      'userName': userName,
      'email': email,
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<dynamic> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage);
      emit(SqueakProfileImagePickedSuccessState(profileImage!));
    } else {
      debugPrint('No image selected.');
      emit(SqueakProfileImagePickedErrorState());
    }
  }

  Future requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  String dropDownItem =
      'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais';

  String? dropDownIdItem;
  void changeSelect({
    required String dropDown,
    required String dropDownId,
  }) {
    dropDownItem = '';
    dropDownItem = dropDown;
    dropDownIdItem = dropDownId;
    print(dropDownItem);
    print(dropDownIdItem);
    emit(ChangeStateVacState());
  }
}
