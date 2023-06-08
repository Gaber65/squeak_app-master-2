import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/network/end-points.dart';
import '../../../../../core/service/dio_client.dart';
import '../../../../../core/service/server_error.dart';
import '../../../../../core/service/service_locator.dart';
import '../../domain/entities/add_peets_data.dart';
import '../../domain/entities/beeds_type_data.dart';
import '../../domain/entities/edit_pets_data.dart';
import '../../domain/entities/find_pet_by_owner_id_data.dart';
import '../model/add_peets_model.dart';
import '../model/beeds_type_model.dart';
import '../model/edit_pets_model.dart';
import '../model/find_pet_by_owner_id_model.dart';

class beedsRepository {
  static String _token = '';
  static String? _userId;

  /////////////////////////////////////////////////////////////
  Future<Either<ServerError, FindPetByOwnerIdData>> GetPetByID(
      {required String petid}) async {
    print("${GetpetByIdUrl}?petid=$petid");

    final response = await DioClient.getData(
      url: "${GetpetByIdUrl}?petid=$petid",
      // token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJtb2hhbWVkMTFAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9wcmltYXJ5c2lkIjoiZmVlNTMzZTktNzY3NS00Zjg0LThkOGQtODdlNjg5MDUwMmE0IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZ2l2ZW5uYW1lIjoic3FxdHJpbmciLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiIxIiwiZXhwIjoxNjk4MzU0ODI4LCJpc3MiOiJodHRwOi8vYW9tYXIyMDEwLTAwMS1zaXRlMS5idGVtcHVybC5jb20vIiwiYXVkIjoiaHR0cDovL2FvbWFyMjAxMC0wMDEtc2l0ZTEuYnRlbXB1cmwuY29tLyJ9.df8M6FTHBO9nUCEz0NJs_ccZtS14VDgE55Xz-W3JQZ0",

      token: sl<SharedPreferences>().getString('token'),
      // query: {
      //     'petid': petid,
      //   },
    );
    return response.fold(
      (error) => Left(error),
      (body) {
        final FindPetByOwnerIdModel authResponse =
            FindPetByOwnerIdModel.fromJson(body.data);
        return Right(authResponse);
      },
    );
  }

  /////////////////////////////////////////////////////////////
  Future<Either<ServerError, BreedTypeData>> GetBeedsType(
      {required int speciesId}) async {
    final response = await DioClient.getData(
      url: GetBreedsUrl,
      token: sl<SharedPreferences>().getString('token'),
      query: {
        'speciesId': speciesId,
      },
    );
    return response.fold(
      (error) => Left(error),
      (body) {
        final BreedTypeModel authResponse = BreedTypeModel.fromJson(body.data);
        return Right(authResponse);
      },
    );
  }

  /////////////////////////////////////////////////////////////
  Future<Either<ServerError, FindPetByOwnerIdData>> FindPetByOwnerId() async {
    final response = await DioClient.getData(
      url: FindPetByOwnerIdUrl,
      token: sl<SharedPreferences>().getString('token'),
      //   token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJtb2hhbWVkMTFAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9wcmltYXJ5c2lkIjoiZmVlNTMzZTktNzY3NS00Zjg0LThkOGQtODdlNjg5MDUwMmE0IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZ2l2ZW5uYW1lIjoic3FxdHJpbmciLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiIxIiwiZXhwIjoxNjk4MzU0ODI4LCJpc3MiOiJodHRwOi8vYW9tYXIyMDEwLTAwMS1zaXRlMS5idGVtcHVybC5jb20vIiwiYXVkIjoiaHR0cDovL2FvbWFyMjAxMC0wMDEtc2l0ZTEuYnRlbXB1cmwuY29tLyJ9.df8M6FTHBO9nUCEz0NJs_ccZtS14VDgE55Xz-W3JQZ0",
    );
    return response.fold(
      (error) => Left(error),
      (body) {
        final FindPetByOwnerIdModel authResponse =
            FindPetByOwnerIdModel.fromJson(body.data);
        return Right(authResponse);
      },
    );
  }

  Future<Either<ServerError, AddNewPetData>> AddPets(FormData data) async {
    final response = await DioClient.postFormData(
        url: AddBreedsUrl,
        token: sl<SharedPreferences>().getString('token'),
        // token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJtb2hhbWVkMTFAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9wcmltYXJ5c2lkIjoiZmVlNTMzZTktNzY3NS00Zjg0LThkOGQtODdlNjg5MDUwMmE0IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZ2l2ZW5uYW1lIjoic3FxdHJpbmciLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiIxIiwiZXhwIjoxNjk4MzU0ODI4LCJpc3MiOiJodHRwOi8vYW9tYXIyMDEwLTAwMS1zaXRlMS5idGVtcHVybC5jb20vIiwiYXVkIjoiaHR0cDovL2FvbWFyMjAxMC0wMDEtc2l0ZTEuYnRlbXB1cmwuY29tLyJ9.df8M6FTHBO9nUCEz0NJs_ccZtS14VDgE55Xz-W3JQZ0",
        data: data);
    return response.fold(
      (error) => Left(error),
      (body) {
        final AddNewPetModel authResponse = AddNewPetModel.fromJson(body.data);
        return Right(authResponse);
      },
    );
  }

  Future<Either<ServerError, EditPetData>> EditPets(
      FormData data, String id) async {
    print("${EditBreedsUrl + id}");

    final response = await DioClient.putFormData(
        url: "${EditBreedsUrl + id}",
        token: sl<SharedPreferences>().getString('token'),
        // token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJtb2hhbWVkMTFAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9wcmltYXJ5c2lkIjoiZmVlNTMzZTktNzY3NS00Zjg0LThkOGQtODdlNjg5MDUwMmE0IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZ2l2ZW5uYW1lIjoic3FxdHJpbmciLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiIxIiwiZXhwIjoxNjk4MzU0ODI4LCJpc3MiOiJodHRwOi8vYW9tYXIyMDEwLTAwMS1zaXRlMS5idGVtcHVybC5jb20vIiwiYXVkIjoiaHR0cDovL2FvbWFyMjAxMC0wMDEtc2l0ZTEuYnRlbXB1cmwuY29tLyJ9.df8M6FTHBO9nUCEz0NJs_ccZtS14VDgE55Xz-W3JQZ0",
        data: data);
    return response.fold(
      (error) => Left(error),
      (body) {
        final EditPetModel authResponse = EditPetModel.fromJson(body.data);
        return Right(authResponse);
      },
    );
  }
}
