import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/features/layout/data/models/all_clinic_model.dart';
import 'package:squeak/features/layout/data/models/follow_model.dart';
import 'package:squeak/features/layout/data/models/vaccination_model.dart';
import 'package:squeak/features/layout/domain/base_repository/base_clinic_repo.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../../../../core/network/dio.dart';
import '../../../../core/network/end-points.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/error/error_message_model.dart';
import '../../../availability/data/model/availabilities/delete_availabilities_model.dart';
import '../../domain/use_case/post_use_case/get_doctor_posts_use_case.dart';
import '../models/add_clinic_model.dart';
import '../models/all_clinic_follow_model.dart';
import '../models/create_post_model.dart';
import '../models/get_doctor_post_model.dart';
import '../models/get_follower_clinic_model.dart';
import '../models/specialities_model.dart';

abstract class BaseClinicRemoteDataSource {
  ///Clinic
  Future<AddClinicEntitiesModel> addClinicDataSource(
      AddClinicParameters parameters);
  //search
  Future<AllClinicModel> allClinicsDataSource(
      AllFollowClinicParameters parameters);
  Future<SpecialitiesModel> allSpecialitiesDataSource();
  Future<AllClinicFollowModel> allClinicsFollowDataSource(
      AllFollowClinicParameters parameters);
  Future<AllClinicModel> updateClinicDataSource(AddClinicParameters parameters);
  Future<DeleteAvailabilitiesModel> deleteClinicDataSource(
      FollowClinicParameters parameters);
  Future<ClinicFollowersModel> getFollowerClinicDataSource();

  Future<FollowModel> followClinicsDataSource(
      FollowClinicParameters parameters);
  Future<FollowModel> unfollowClinicsDataSource(
      FollowClinicParameters parameters);
  Future<FollowModel> blockUserFollowClinicsDataSource(
      BlockUserClinicParameters parameters);
  Future<AllClinicModel> allClinicsSupplierDataSource(
      AllFollowClinicParameters parameters);

  ///Vaccination
  Future addVaccination(VaccinationParameters parameters);
  Future getVaccination(VaccinationParameters parameters);
  Future<VaccinationModel> updateVaccination(VaccinationParameters parameters);
  Future<VaccinationNameModel> getVaccinationName(
      VaccinationNameParameters parameters);

  ///todo Posts
  Future<CreatePostModel> createClinicPostDataSource(
      AddPostParameters parameters);
  Future<CreatePostModel> deleteClinicPostDataSource(
      AddPostParameters parameters);
  Future<CreatePostModel> updateClinicPostDataSource(
      AddPostParameters parameters);
  Future<PostDoctorModel> getDoctorClinicPostDataSource(
      GetPostParameters parameters);
  Future<PostDoctorModel> getClinicPostDataSource(GetPostParameters parameters);
}

class ClinicRemoteDataSource extends BaseClinicRemoteDataSource {
  @override
  Future<AddClinicEntitiesModel> addClinicDataSource(
      AddClinicParameters parameters) async {
    try {
      final result = await DioFinalHelper.postData(
        method: '$version$addClinicEndPoint',
        data: {
          "name": parameters.name,
          "Location": parameters.location,
          "City": parameters.city,
          "address": parameters.address,
          "Image": parameters.image,
          "Code": parameters.code,
          "Specialities": [(parameters.speciality)],
          "phone": parameters.phone,
        },
        token: "${sl<SharedPreferences>().getString('refreshToken')}",
      );

      return AddClinicEntitiesModel.fromJson(result!.data!);
    } on DioException catch (error) {
      return AddClinicEntitiesModel.fromJson(error.response!.data);
    }
  }

  @override
  Future<AllClinicModel> allClinicsDataSource(
      AllFollowClinicParameters parameters) async {
    var result = await DioFinalHelper.getData(
      method: '$version$allClinicEndPoint?name=${parameters.adminId}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return AllClinicModel.fromJson(result.data!);
  }

  @override
  Future<FollowModel> followClinicsDataSource(
      FollowClinicParameters parameters) async {
    var result = await DioFinalHelper.postData(
        method: '$version$followClinicEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "clinicId": parameters.clinicId,
          // "userId": "${sl<SharedPreferences>().getString('clintId')}"
        });
    return FollowModel.fromJson(result.data!);
  }

  @override
  Future<FollowModel> unfollowClinicsDataSource(
      FollowClinicParameters parameters) async {
    var result = await DioFinalHelper.postData(
        method: '$version$unfollowClinicEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "ClinicId": parameters.clinicId,
          // "userId": "${sl<SharedPreferences>().getString('clintId')}"
        });
    ;
    return FollowModel.fromJson(result.data!);
  }

  @override
  Future<AllClinicFollowModel> allClinicsFollowDataSource(
      AllFollowClinicParameters parameters) async {
    var result = await DioFinalHelper.getData(
      method: '$version${allClinicFollowerEndPoint(parameters.adminId)}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return AllClinicFollowModel.fromJson(result.data!);
  }

  @override
  Future addVaccination(VaccinationParameters parameters) async {
    VaccinationModel model = VaccinationModel(
      vacName: parameters.vacName,
      vacDate: parameters.vacDate,
      vacTime: parameters.vacTime,
      vacComment: parameters.vacComment,
      vacState: parameters.vacState,
      petId: parameters.petId,
      vacId: parameters.vacId,
    );
    try {
      FirebaseFirestore.instance
          .collection('vaccination')
          .doc(parameters.petId)
          .set(model.toMap());
    } catch (error) {
      rethrow;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var request =
        http.Request('POST', Uri.parse('$baseApiUrl$version$petVacEndPoint'));
    request.body = json.encode({
      "petId": parameters.petId,
      "vacId": parameters.vacName,
      "date": parameters.vacDate,
      "comment": parameters.vacComment,
      "statues": parameters.vacState,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return VaccinationModel.fromJson(headers);
  }

  @override
  Future getVaccination(VaccinationParameters parameters) async {
    try {
      List<VaccinationModel> vaccinationList = [];
      FirebaseFirestore.instance
          .collection('vaccination')
          .doc(parameters.petId)
          .snapshots()
          .listen((value) {
        vaccinationList = [];
        vaccinationList.add(VaccinationModel.fromJson(value.data()!));
      });
    } catch (error) {
      rethrow;
    }
    var headers = {'Authorization': token};
    var request = http.Request(
        'GET', Uri.parse('$baseApiUrl$version/PetVac/Pet/${parameters.petId}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return VaccinationModel.fromJson(headers);
  }

  @override
  Future<VaccinationNameModel> getVaccinationName(
      VaccinationNameParameters parameters) async {
    Map<String, dynamic>? data;
    var r = await DioFinalHelper.getData(
      method: '$version$allVacEndPoint',
      token: sl<SharedPreferences>().getString('refreshToken'),
    ).then((value) {
      data = value.data;
      print(value.data);
    });
    return VaccinationNameModel.fromJson(data!);
  }

  @override
  Future<VaccinationModel> updateVaccination(
      VaccinationParameters parameters) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var request = http.Request(
        'PUT', Uri.parse('$baseApiUrl$version/PetVac/${parameters.vacId}'));
    request.body = json.encode({
      "petId": "3FA85F64-5720-4362-B3FC-2C963F66AFA6",
      "vacId": "30FF2DF9-DAAC-43EF-B194-36F38EA2B2F9",
      "comment": "Update Comment",
      "statues": false
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return VaccinationModel.fromJson(headers);
  }

  @override
  Future<SpecialitiesModel> allSpecialitiesDataSource() async {
    Map<String, dynamic>? data;
    var r = await DioFinalHelper.getData(
      method: '$version$allSpecialityPetEndPoint',
      token: sl<SharedPreferences>().getString('refreshToken'),
    ).then((value) {
      data = value.data;
      print(value.data);
    });
    return SpecialitiesModel.fromJson(data!);
  }

  @override
  Future<FollowModel> blockUserFollowClinicsDataSource(
      BlockUserClinicParameters parameters) async {
    var result = await DioFinalHelper.patchData(
        method: '$version$blockFollowerEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {"clinicId": parameters.clinicId, "userId": parameters.userId});
    return FollowModel.fromJson(result.data!);
  }

  @override
  Future<CreatePostModel> createClinicPostDataSource(
      AddPostParameters parameters) async {
    try {
      var result = await DioFinalHelper.postData(
          method: '$version$createPostEndPoint',
          token: sl<SharedPreferences>().getString('refreshToken'),
          data: {
            "title": parameters.title,
            "content": parameters.content,
            "image": parameters.image,
            "video": parameters.video,
            "clinicId": parameters.clinicId,
            "specieId": parameters.specieId,
          });
      return CreatePostModel.fromJson(result.data!);
    } on DioException catch (error) {
      return CreatePostModel.fromJson(error.response!.data);
    }
  }

  @override
  Future<CreatePostModel> deleteClinicPostDataSource(
      AddPostParameters parameters) async {
    // TODO: implement deleteClinicPostDataSource
    var result = await DioFinalHelper.deleteData(
      method: '$version$deletePostEndPoint/${parameters.postId}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return CreatePostModel.fromJson(result.data!);
  }

  @override
  Future<PostDoctorModel> getClinicPostDataSource(GetPostParameters parameters) async {
    // TODO: implement deleteClinicPostDataSource
    final result = await DioFinalHelper.getData(
      method: '$version${getPostEndPoint(
        parameters.pageNumber,
      )}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return PostDoctorModel.fromJson(result.data!);
  }

  @override
  Future<CreatePostModel> updateClinicPostDataSource(
      AddPostParameters parameters) async {
    // TODO: implement updateClinicPostDataSource
    var result = await DioFinalHelper.patchData(
        method: '$version$updatePostEndPoint${parameters.postId}',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "title": parameters.title,
          "content": parameters.content,
          "image": parameters.image,
          "video": parameters.video,
          "clinicId": parameters.clinicId,
          "specieId": parameters.specieId,
          "id": parameters.postId
        });
    return CreatePostModel.fromJson(result.data!);
  }

  @override
  Future<AllClinicModel> allClinicsSupplierDataSource(
      AllFollowClinicParameters parameters) async {
    var result = await DioFinalHelper.getData(
      method:
          '$version$allClinicEndPoint?Admin=${sl<SharedPreferences>().getString('clintId')}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return AllClinicModel.fromJson(result.data!);
  }

  @override
  Future<AllClinicModel> updateClinicDataSource(
      AddClinicParameters parameters) async {
    var result = await DioFinalHelper.patchData(
      method: '$version$updateClinicEndPoint${parameters.clinicId}',
      token: sl<SharedPreferences>().getString('refreshToken'),
      data: {
        "name": parameters.name,
        "Location": parameters.location,
        "City": parameters.city,
        "address": parameters.address,
        "Image": parameters.image,
        "Code": parameters.code,
        "Specialities": ['${parameters.speciality}'],
        "phone": parameters.phone,
      },
    );
    return AllClinicModel.fromJson(result.data!);
  }

  @override
  Future<DeleteAvailabilitiesModel> deleteClinicDataSource(
      FollowClinicParameters parameters) async {
    var result = await DioFinalHelper.deleteData(
      method: '$version$deleteClinicEndPoint${parameters.clinicId}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return DeleteAvailabilitiesModel.fromJson(result.data!);
  }

  @override
  Future<PostDoctorModel> getDoctorClinicPostDataSource(
      GetPostParameters parameters
      ) async {
    var result = await DioFinalHelper.getData(
      method: '$version${getDoctorPostEndPoint(
        parameters.pageNumber,
      )}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return PostDoctorModel.fromJson(result.data!);
  }

  @override
  Future<ClinicFollowersModel> getFollowerClinicDataSource() async {
    var result = await DioFinalHelper.getData(
      method: '$version$getFollowerClinicEndPoint',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return ClinicFollowersModel.fromJson(result.data!);
  }
}
