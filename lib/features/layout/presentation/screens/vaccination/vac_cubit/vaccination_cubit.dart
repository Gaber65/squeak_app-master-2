import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/dio.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/add_peets_data.dart';
import 'package:squeak/features/setting/update_profile/domain/repository/base_update_profile_repository.dart';

import '../../../../../../core/network/end-points.dart';
import '../../../../../../core/service/service_locator.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../../../../setting/update_profile/domain/entities/vaccination_entities.dart';
import '../../../../../setting/update_profile/domain/usecase/add_vac_pet_use_case.dart';
import '../../../../../setting/update_profile/domain/usecase/get_all_vac_use_case.dart';
import 'package:sqflite/sqflite.dart';

part 'vaccination_state.dart';

class VaccinationCubit extends Cubit<VaccinationState> {
  VaccinationCubit(this.getAllVacUseCase, this.postVacPetsUseCase)
      : super(VaccinationInitial());
  static VaccinationCubit get(context) => BlocProvider.of(context);
  bool isButtonSheetShown = false;

  void changeBottomSheetShow({
    required bool isShow,
  }) {
    isButtonSheetShown = !isShow;
    emit(AppChangeBottomSheetState());
  }

  Database? database;
  List<Map> newRecord = [];

  void createDatabase(petId) {
    emit(AppCreateDatabaseLoadingState());
    openDatabase(
      'record.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE task(id INTEGER PRIMARY KEY, data TEXT ,pitName TEXT,gender INTEGER,typeVaccination TEXT,comments TEXT,time TEXT ,petId TEXT)')
            .then((value) {
          print('DB Created');
        }).catchError((error) {
          print('Error whe create Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getFromDatabase(database, petId);
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
    required String data,
    required String comments,
    required String petId,
  }) async {
    database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO task(data,pitName,gender,typeVaccination,comments,petId) VALUES("$data","$pitName","$gender","$typeVaccination","$comments","$petId")')
          .then((value) {
        print('$value Inserted successfully');
        emit(AppInsertDatabaseState());
        getFromDatabase(database, petId).then((value) {
          emit(AppGetDatabaseState());
        });
      }).catchError((error) {
        print('Error whe Inserting New Record   ${error.toString()}');
      });
      return await null;
    });
  }

  getFromDatabase(database, String petId) {
    newRecord = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM task').then((value) {
      value.forEach((element) {
        if (element['petId'] == '$petId') {
          newRecord.add(element);
        }
        emit(AppGetDatabaseState());
      });
    });
  }

  Future<void> updateDate({
    required String comments,
    required String petId,
    required dynamic id,
    required dynamic gender,
    required String data,
    required String typeVaccination,
    required String typeId,
    required String pitName,
    required bool statues,
  }) async {
    database!.rawUpdate('UPDATE task SET comments = ? WHERE id = ?',
        [comments, '$id']).then((value) {
      print(comments);
      getFromDatabase(database, petId);
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('pet')
          .doc(petId)
          .collection('vacs')
          .doc(id)
          .update({
        'pitName': pitName,
        'typeVaccination': typeVaccination,
        'gender': gender,
        'data': data,
        'comments': comments,
        'petId': petId,
        'statues': statues,
        'typeId': typeId,
      });
      DioFinalHelper.patchData(
        method: '$version$petVacEndPoint/$typeId',
        token: "${sl<SharedPreferences>().getString('refreshToken')}",
        data: {
          "id": typeId,
          "petId": petId,
          "vaccinationId": typeId,
          "vacDate": data,
          "status": true,
          "comment": comments
        },
      ).then((value) {
        print('Success Edit vac');
      });
      emit(AppUpDateDatabaseState());
    });
  }

  Future<void> deleteDate({
    required dynamic id,
    required String petId,
  }) async {
    database!.rawDelete('DELETE FROM task WHERE id = ?', [id]).then((value) {
      getFromDatabase(database, petId);

      emit(AppDeleteDatabaseState());
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('pet')
        .doc(petId)
        .collection('vacs')
        .doc(id)
        .delete()
        .then((value) {
      emit(AppDeleteDatabaseState());
    });
  }

  VacEntities? vacEntities;
  GetAllVacUseCase getAllVacUseCase;
  Future<void> getVaccinationName() async {
    emit(GetVaccinationLoadingState());
    final result = await getAllVacUseCase(const NoParameters());
    result.fold(
      (l) {
        emit(GetVaccinationErrorState(l.message));
      },
      (r) {
        vacEntities = r;
        print(r);
        emit(GetVaccinationSuccessState(r));
      },
    );
  }

  AddNewPetData? addNewPetData;
  PostVacPetsUseCase postVacPetsUseCase;
  Future<void> createVac({
    required String petId,
    required int gender,
    required String data,
    required String comments,
    required String typeVaccination,
    required String typeId,
    required String pitName,
    required bool statues,
  }) async {
    emit(AddVaccinationLoadingState());

    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(uId)
    //     .collection('pet')
    //     .doc(petId)
    //     .collection('vacs')
    //     .doc()
    //     .set({
    //   'pitName': pitName,
    //   'typeVaccination': typeVaccination,
    //   'gender': gender,
    //   'data': data,
    //   'comments': comments,
    //   'petId': petId,
    //   'statues': statues,
    //   'typeId': typeId,
    // });
    final result = await postVacPetsUseCase(
      PostVacPetsParameters(
        petId: petId,
        vacDate: data,
        comment: comments,
        statues: statues,
        vaccinationId: typeId,
      ),
    );
    result.fold((l) {
      emit(AddVaccinationErrorState(l.message));
    }, (r) {
      emit(AddVaccinationSuccessState(r));
    });
  }

  List<Map> list = [];
  List<String> ids = [];
  Future<void> getVacPet({required String petId}) async {
    emit(GetVaccinationFireLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('pet')
        .doc(petId)
        .collection('vacs')
        .snapshots()
        .listen((event) {
      list = [];

      emit(GetVaccinationFireSuccessState());
      print(event.docs);

      for (var element in event.docs) {
        list.add(element.data());
        ids.add(element.id);
        print(
            '***********************************${element.data()}****************************');
      }
    });
  }

  bool edit = false;
  void changeEdit({
    required String comments,
    required String petId,
    required dynamic id,
    required dynamic gender,
    required String data,
    required String typeVaccination,
    required String typeId,
    required String pitName,
  }) {
    edit = !edit;
    print(edit);
    getFromDatabase(database, petId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('pet')
        .doc(petId)
        .collection('vacs')
        .doc(id)
        .update({
      'statues': edit,
    });

    emit(ChangeSettingModeState());
  }

  bool stateVac = false;
  void changeState() {
    stateVac = !stateVac;
    print(stateVac);
    emit(ChangeStateVacState());
  }

  String valueVacItem = 'Select Service';
  String valueIdItem = '';

  void changeSelect({required String vacName, required String vacId}) {
    valueVacItem = vacName;
    valueIdItem = vacId;
    print('************$vacName');
    emit(ChangeStateVacState());
  }

  DateTime? currentDateItem = DateTime.now();
  String? timeDateItem;
  void changeSelectDate(
      {required DateTime currentDate, required String timeDate}) {
    currentDateItem = currentDate;
    timeDateItem = timeDate;
    print('************$timeDate');
    emit(ChangeStateVacState());
  }
}
