import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squeak/core/network/dio_helper.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/cubit/squeak_state.dart';
import 'package:squeak/features/layout/home/home.dart';
import 'package:squeak/features/layout/nav/nav.dart';
import 'package:squeak/features/layout/profile/domain/entities/profile.dart';
import 'package:squeak/features/layout/profile/domain/usecase/get_breeds_use_case.dart';
import 'package:squeak/features/layout/profile/domain/usecase/get_owner_pets.dart';
import 'package:squeak/features/layout/profile/domain/usecase/get_profile_user_use_case.dart';
import 'package:squeak/features/layout/time/time.dart';
import 'package:squeak/features/layout/profile/presentation/pages/profile.dart';
import 'package:squeak/features/layout/update_profile/domain/entities/update_profile.dart';
import 'package:squeak/features/layout/update_profile/domain/repository/base_update_profile_repository.dart';
import 'package:squeak/features/layout/update_profile/domain/usecase/get_update_profile_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:sqflite/sqflite.dart';

import '../profile/domain/entities/owner_pets.dart';
import '../profile/domain/entities/pets_entities.dart';
import '../profile/domain/entities/species_entities.dart';
import '../profile/domain/usecase/post_pets_use_case.dart';
import '../profile/domain/usecase/update_pits_use_case.dart';

class SqueakCubit extends Cubit<SqueakState> {
  SqueakCubit(
    this.getProfileUseData,
    this.getUpdateProfileUseCase,
    this.postPetsUseCase,
    this.getBreedsUseCase,
    this.getOwnerPetsUseCase,
    this.updatePetsUseCase,
  ) : super(SqueakInitialState());

  final GetProfileUseCase getProfileUseData;
  final GetUpdateProfileUseCase getUpdateProfileUseCase;

  Profile? profile;
  UpdateProfile? updateProfile;

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
          Icons.person_2_outlined,
          size: AppSize.s30,
        ),
        label: ''),
  ];
  List<Widget> screens = [
    HomeScreen(),
    const TimeScreen(),
    const NavScreen(),
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

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var genderController = TextEditingController();
  var phoneController = TextEditingController();
  var birthdateController = TextEditingController();
  var addressController = TextEditingController();
  var imageController = TextEditingController();

  Future<dynamic> getProfile() async {
    emit(SqueakProfileDataLoadingState());

    final result = await getProfileUseData(const NoParameters());

    result.fold(
      (l) {
        emit(SqueakProfileDataErrorState(l.message));
      },
      (r) {
        profile = r;
        // getUpdateProfile(
        //   fullName: fullNameController.text,
        //   emailAddress: emailController.text,
        //   phone: phoneController.text,
        //   imageName: imageController.text,
        //   address: addressController.text,
        //   gender: genderController.text,
        // );
        emit(SqueakProfileDataSuccessState(r));
      },
    );
  }

  final GetOwnerPetsUseCase getOwnerPetsUseCase;
  late OwnerPetsEntities ownerPetsEntities;
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
    required String emailAddress,
    required String phone,
    required String imageName,
    required String address,
    required String gender,
    required String Birthdate,
    required String Imagepath,
  }) async {
    emit(SqueakUpdateProfileLoadingState());

    final result = await getUpdateProfileUseCase(
      UpdateProfileParameters(
          fullName: fullName,
          email: emailAddress,
          phone: phone,
          addresss: address,
          image: imageName,
          gender: gender,
          Birthdate: Birthdate,
          Imagepath: Imagepath),
    );
    result.fold(
      (l) {
        emit(SqueakUpdateProfileErrorState(l.message));
      },
      (r) {
        updateProfile = r;
        UpdateProfileParameters(
            fullName: fullName,
            email: emailAddress,
            phone: phone,
            addresss: address,
            image: imageName,
            gender: gender,
            Birthdate: Birthdate,
            Imagepath: Imagepath);

        imageController.text = updateProfile!.data!.owner!.imageName!;
        emit(SqueakUpdateProfileSuccessState(r));
      },
    );
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<dynamic> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage);
      // String fileName = profileImage!.path.split('/').last;
      // FormData formData = FormData.fromMap({
      //   'image' : await MultipartFile.fromFile(profileImage!.path,filename: fileName,
      //       contentType: MediaType('image','png')),
      //   'type' : 'image/png',
      // });
      // Response response =
      // await dio.post('path',data: formData, options: Options(
      //     headers: {
      //       'accept' : '*/*',
      //       'Authorization' : 'Bearer accesstoken',
      //       'Content-Type' : 'multipart/form-data',
      //     },
      // ));
      emit(SqueakProfileImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SqueakProfileImagePickedErrorState());
    }
  }

  final PostPetsUseCase postPetsUseCase;
  late PetsEntities petsEntities;
  Future<void> addPets({
    required String petName,
    required int gender,
    required int species,
    required String birthdate,
    required String breedId,
  }) async {
    emit(SqueakAddPetsLoadingState());

    final result = await postPetsUseCase(
      PostPetsParameters(
        petName: petName,
        gender: gender,
        species: species,
        birthdate: birthdate,
        image: pitsImage!,
        imageName: imageController.text,
        ownerClientId: token!,
        breedId: breedId,
      ),
    );
    result.fold(
      (l) => emit(
        SqueakUAddPetsErrorState(l.message),
      ),
      (r) => emit(
        SqueakAddPetsSuccessState(r),
      ),
    );
  }

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

  final GetBreedsUseCase getBreedsUseCase;
  SpeciesEntities? speciesEntities;
  Future<void> getBreed({required int speciesId}) async {
    emit(SqueakGetBreedLoadingState());
    final result = await getBreedsUseCase(
      GetBreedParameters(
        speciesId: speciesId,
      ),
    );
    result.fold(
      (l) => emit(
        SqueakUGetBreedErrorState(l.message),
      ),
      (r) => emit(
        SqueakGetBreedSuccessState(r),
      ),
    );
    print(result.toString());
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

  Future<void> updatePits({
    required String petName,
    required int gender,
    required int species,
    required String birthdate,
    required String breedId,
    required String petId,
  }) async {
    emit(SqueakUpdatePetsLoadingState());
    final result = await updatePetsUseCase(
      UpdatePetsParameters(
        petId: petId,
        gender: gender,
        petName: petName,
        image: updatePitsImage!,
        species: species,
        birthdate: birthdate,
      ),
    );
    result.fold(
      (l) => emit(
        SqueakUpdatePetsErrorState(l.message),
      ),
      (r) => emit(
        SqueakUpdatePetsSuccessState(r),
      ),
    );
    print(result.toString());
  }

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

  Database? database;
  List<Map> newRecord = [];

  void createDatabase() {
    openDatabase(
      'record.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE task (id INTEGER PRIMARY KEY, data TEXT ,pitName TEXT,gender INTEGER,typeVaccination TEXT,time TEXT ,status TEXT) ')
            .then((value) {
          print('DB Created');
        }).catchError((error) {
          print('Error whe create Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getFromDatabase(database);
        print('Database onOpen');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String pitName,
    required String typeVaccination,
    required int gender,
    required String time,
    required String data,
  }) async {
    database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO task(pitName,data,time,gender,typeVaccination,status) VALUES("$pitName","$data","$time","$gender","$typeVaccination","new")')
          .then((value) {
        print('$value Inserted successfully');
        emit(AppInsertDatabaseState());
        getFromDatabase(database).then((value) {
          emit(AppGetDatabaseState());
        });
      }).catchError((error) {
        print('Error whe Inserting New Record   ${error.toString()}');
      });
      return await null;
    });
  }

  getFromDatabase(database) {
    newRecord = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM task').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newRecord.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }
  void updateDate({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate('UPDATE task SET status = ? WHERE id = ?',
        [status, '$id']).then((value) {
      print(status);
      getFromDatabase(database);
      emit(AppUpDateDatabaseState());
    });
  }

  void deleteDate({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM task WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
