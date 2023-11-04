import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/resources/constants_manager.dart';

import '../../../features/layout/layout.dart';
import '../../../features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import '../../../features/layout/presentation/controller/post_cubit/post_cubit.dart';
import '../../../features/social_media/presentation/components/chat_hub_connection.dart';
import '../../service/service_locator.dart';
import '../../widgets/components/hub_connection.dart';
import '../dio.dart';
import '../end-points.dart';
import 'helper_model/helper_model.dart';
import 'package:http_parser/http_parser.dart';

import 'helper_model/refresh_model.dart';

part 'helper_state.dart';

class UploadPlace {
  int postImages = 1;
  int petsImages = 2;
  int uploads = 3;
  int usersImages = 4;
  int postVideos = 5;
  int commentImages = 6;
  int clinicImage = 7;
  int messageImage = 8;
  int messageRecord = 9;
}

class HelperCubit extends Cubit<HelperState> {
  HelperCubit() : super(HelperInitial());

  static HelperCubit get(context) => BlocProvider.of(context);

  HelperModel? modelImage;

  Future<void> getGlobalImage({
    required File file,
    required int uploadPlace,
  }) async {
    String fileName = file.path.split('/').last;
    String filePath = file.path;
    emit(ImageHelperLoading());
    final dio = await Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
        baseUrl: '$baseApiUrl$version',
        headers: {
          'Authorization':
              'Bearer ${sl<SharedPreferences>().getString('refreshToken')}',
          // 'Content-Type': 'multipart/form-data'
        },
      ),
    ).post(
      imageHelperEndPoint,
      data: FormData.fromMap({
        "File": await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: new MediaType("image", "jpeg"), //add this
        ),
        'UploadPlace': '$uploadPlace'
      }),
      onReceiveProgress: (count, total) {
        print('$count , $total');
      },
    ).then((value) {
      modelImage = HelperModel.fromJson(value.data);
      emit(ImageHelperSuccess(HelperModel.fromJson(value.data)));
      print(modelImage!.data);
    }).catchError((onError) {
      print("******************$onError********************");
      emit(ImageHelperError());
    });
  }

  HelperModel? modelVideo;

  Future<void> getGlobalVideo({
    required File file,
    required int uploadPlace,
  }) async {
    String fileName = file.path.split('/').last;
    String filePath = file.path;
    emit(ImageHelperLoading());
    final dio = await Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
        baseUrl: '$baseApiUrl$version',
        headers: {
          'Authorization':
              'Bearer ${sl<SharedPreferences>().getString('refreshToken')}',
          // 'Content-Type': 'multipart/form-data'
        },
      ),
    ).post(
      videoHelperEndPoint,
      data: FormData.fromMap({
        "File": await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: new MediaType("video", "mp4"), //add this
        ),
        'UploadPlace': '$uploadPlace'
      }),
      onReceiveProgress: (count, total) {
        print('$count , $total');
      },
    ).then((value) {
      modelVideo = HelperModel.fromJson(value.data);
      emit(ImageHelperSuccess(HelperModel.fromJson(value.data)));
      print(modelVideo!.data);
    }).catchError((onError) {
      print("******************$onError********************");
      emit(ImageHelperError());
    });
  }

  HelperModel? modelSound;

  Future<void> getGlobalSound({
    required File file,
    required int uploadPlace,
  }) async {
    String fileName = file.path.split('/').last;
    String filePath = file.path;
    emit(ImageHelperLoading());
    try {
      final dio = await Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveDataWhenStatusError: true,
          baseUrl: '$baseApiUrl$version',
          headers: {
            'Authorization':
                'Bearer ${sl<SharedPreferences>().getString('refreshToken')}',
            // 'Content-Type': 'multipart/form-data'
          },
        ),
      ).post(
        audioHelperEndPoint,
        data: FormData.fromMap({
          "File": await MultipartFile.fromFile(
            filePath,
            filename: fileName,
            contentType: new MediaType(
              "audio",
              "Acc",
            ), //add this
          ),
          'UploadPlace': '$uploadPlace'
        }),
        onReceiveProgress: (count, total) {
          print('$count , $total');
        },
      );
      modelSound = HelperModel.fromJson(dio.data);
      emit(ImageHelperSuccess(HelperModel.fromJson(dio.data)));
      print(modelSound!.data);
    } on DioException catch (error) {
      emit(ImageHelperError());
      print(error.response);
    }
  }

  Future<void> getRefreshToken({
    required BuildContext context,
  }) async {
    print('{**************************}');
    emit(GetRefreshTokenLoading());
    DioFinalHelper.postData(
      method: '$version$loginEndPoint',
      data: {
        "emailOrUsername": sl<SharedPreferences>().getString('email'),
        "Password": sl<SharedPreferences>().get('password')
      },
    ).then(
      (value) {
        RefreshToken model = RefreshToken.fromJson(value.data);
        print(value.data);
        token == '';
        refreshToken = '';
        sl<SharedPreferences>().remove('token');
        sl<SharedPreferences>().remove('refreshToken');
        sl<SharedPreferences>().setString('token', model.data.token);
        sl<SharedPreferences>()
            .setString('refreshToken', model.data.refreshToken)
            .then(
          (value) {
            token = model.data.token;
            refreshToken = model.data.refreshToken;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LayoutScreen(),
              ),
              (route) => false,
            );
          },
        );
        emit(GetRefreshTokenSuccess());
      },
    ).catchError(
      (onError) {
        emit(GetRefreshTokenError(onError.toString()));
        print(onError.toString());
      },
    );
  }

  Future getUserData({
    required BuildContext context,
  }) async {
    emit(GetUserRefreshTokenLoading());
    try {
      final result = await DioFinalHelper.getData(
        method: '$version$getProfileEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
      );
      print(result.data);
      emit(GetUserRefreshTokenSuccess());
      await MyAppNotifications().initPlatformDartServer();
      await ChatNotifications().initPlatformDartServer();
    } on DioException catch (error) {

      emit(GetUserRefreshTokenError(error.message.toString()));
    }
  }
}
