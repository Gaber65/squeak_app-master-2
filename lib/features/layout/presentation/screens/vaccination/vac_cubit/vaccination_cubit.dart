import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

part 'vaccination_state.dart';

class VaccinationCubit extends Cubit<VaccinationState> {
  VaccinationCubit() : super(VaccinationInitial());
  static VaccinationCubit get(context) => BlocProvider.of(context);
  bool isButtonSheetShown = false;

  void changeBottomSheetShow({
    required bool isShow,
  }) {
    isButtonSheetShown = isShow;
    emit(AppChangeBottomSheetState());
  }

  Database? database;
  List<Map> newRecord = [];

  void createDatabase(petId) {
    openDatabase(
      'record.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE task (id INTEGER PRIMARY KEY, data TEXT ,pitName TEXT,gender INTEGER,typeVaccination TEXT,comments TEXT,time TEXT ,statusPetId TEXT) ')
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
    required String time,
    required String data,
    required String comments,
    required String petId,
  }) async {
    database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO task(data,pitName,gender,typeVaccination,comments,time,statusPetId) VALUES("$data","$pitName","$gender","$typeVaccination","$comments","$time","new$petId")')
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

  getFromDatabase(database, petId) {
    newRecord = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM task').then((value) {
      value.forEach((element) {
        if (element['statusPetId'] == 'new$petId') {
          newRecord.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateDate({
    required String status,
    required String petId,
    required int id,
  }) async {
    database!.rawUpdate('UPDATE task SET statuspetId = ? WHERE id = ?',
        [status, '$id']).then((value) {
      print(status);
      getFromDatabase(database, petId);
      emit(AppUpDateDatabaseState());
    });
  }

  void deleteDate({
    required int id,
    required String petId,
  }) {
    database!.rawDelete('DELETE FROM task WHERE id = ?', [id]).then((value) {
      getFromDatabase(database, petId);
      emit(AppDeleteDatabaseState());
    });
  }
}
