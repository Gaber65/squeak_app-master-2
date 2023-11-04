import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/error/error_message_model.dart';
import 'package:squeak/core/error/exception.dart';
import 'package:squeak/core/main_basic/main_basic.dart';

import '../service/service_locator.dart';
import 'end-points.dart';

class DioFinalHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseApiUrl,
        receiveDataWhenStatusError: true,
        headers: {
          "Content-Type": "application/json",
          "Accept-Language": isArabic() ? 'ar' : 'en',
          'Authorization': 'Bearer $refreshToken',
          'Cookie':
              '.AspNetCore.Identity.Application=CfDJ8NldnRtlwshNgUlgpQYWpZbEzvA0qYCL5ZDTQe3BIigqH9DKeCOiJTCtqhxHsN7hwECElyaVKF62nyS6FA65t35_9HEYRg3d4bY8AKDVdKAePC5G9GCPRmY6w3PYS8w_ZQvb1PudjLsRFsg3ea6WHoKynxCoWHpgvyU-iR7XK310X9YuR1ehGCCdL7eP6eY_mOb4n-dTWsm8RQbWzz4F5iwReC3dzgpjacXGfR8rK2fpvtJ6SKjTczBmLd4VprKynp3vIYmKwoF7ffIPHwhLPrrBvwAE4b0Nmrs9SQRqJHs-aHHRXtZlCsFDeDvFZTLZACemiZtFhzanbYWQ564tnUb2ArxYU1-PfrMf_9mmnkqg3sJ9fQGVV0mvv9bmp3V9YO3rD6H0mMV6AKujZEVvZUrM3CMv3HCGQCbfoy_PZLeVXG4q-JgFMGV6nCPVN7Z1NKa-sCH2gyRVoGDN5cwAPEujoTp4vjdLxvSWQHUVP72EArcsWFnyM3bTLiI09OeddXQt7G8JVpXC2LXXWkbIxZ0NeUwC8m6kwp1P_W2vOj0E0W6SpVLSadwd-pRKOjMJNCk91NSxZA5RVySswvNPuersiXu-CdXRrbxXpa1Z01M7343diE4rBeUyUpvriq5P7_ZHxs6lDnIE27lPPYxtmluJ4uPSIJrZhDRgnwlRZf9RWFdH7t4sTh7vIwfyKxNNyeCSzAOHZCTHjT47ktR6YmzX08ghepJJImdUzVzB9lVkeKGNRiWsx7qDJRrvjtAT2A'
        },
      ),
    );
  }

  static Future<dynamic> postData({
    required String method,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers.addAll(
      {
        "Accept-Language": isArabic() ? 'ar' : 'en',
        'Authorization': 'Bearer $refreshToken',
        'Cookie':
            '.AspNetCore.Identity.Application=CfDJ8NldnRtlwshNgUlgpQYWpZbEzvA0qYCL5ZDTQe3BIigqH9DKeCOiJTCtqhxHsN7hwECElyaVKF62nyS6FA65t35_9HEYRg3d4bY8AKDVdKAePC5G9GCPRmY6w3PYS8w_ZQvb1PudjLsRFsg3ea6WHoKynxCoWHpgvyU-iR7XK310X9YuR1ehGCCdL7eP6eY_mOb4n-dTWsm8RQbWzz4F5iwReC3dzgpjacXGfR8rK2fpvtJ6SKjTczBmLd4VprKynp3vIYmKwoF7ffIPHwhLPrrBvwAE4b0Nmrs9SQRqJHs-aHHRXtZlCsFDeDvFZTLZACemiZtFhzanbYWQ564tnUb2ArxYU1-PfrMf_9mmnkqg3sJ9fQGVV0mvv9bmp3V9YO3rD6H0mMV6AKujZEVvZUrM3CMv3HCGQCbfoy_PZLeVXG4q-JgFMGV6nCPVN7Z1NKa-sCH2gyRVoGDN5cwAPEujoTp4vjdLxvSWQHUVP72EArcsWFnyM3bTLiI09OeddXQt7G8JVpXC2LXXWkbIxZ0NeUwC8m6kwp1P_W2vOj0E0W6SpVLSadwd-pRKOjMJNCk91NSxZA5RVySswvNPuersiXu-CdXRrbxXpa1Z01M7343diE4rBeUyUpvriq5P7_ZHxs6lDnIE27lPPYxtmluJ4uPSIJrZhDRgnwlRZf9RWFdH7t4sTh7vIwfyKxNNyeCSzAOHZCTHjT47ktR6YmzX08ghepJJImdUzVzB9lVkeKGNRiWsx7qDJRrvjtAT2A'
      },
    );

    return await dio.post(
      method,
      data: data,
    );
  }

  static Future<dynamic> getData({
    required String method,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers.addAll({
      'Authorization': 'Bearer $refreshToken',
      "Accept-Language": isArabic() ? 'ar' : 'en',
    });
    return await dio
        .get(
      method,
      data: query,
    );
  }

  static Future<dynamic> putData({
    required String method,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers.addAll({
      "Accept-Language": isArabic() ? 'ar' : 'en',
      'Authorization': token,
    });

    return await dio
        .put(
      method,
      data: data,
    );
  }

  static Future<dynamic> patchData({
    required String method,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers.addAll(
      {
        "Accept-Language": isArabic() ? 'ar' : 'en',
        'Authorization': 'Bearer $refreshToken',
        'Cookie':
            '.AspNetCore.Identity.Application=CfDJ8NldnRtlwshNgUlgpQYWpZbEzvA0qYCL5ZDTQe3BIigqH9DKeCOiJTCtqhxHsN7hwECElyaVKF62nyS6FA65t35_9HEYRg3d4bY8AKDVdKAePC5G9GCPRmY6w3PYS8w_ZQvb1PudjLsRFsg3ea6WHoKynxCoWHpgvyU-iR7XK310X9YuR1ehGCCdL7eP6eY_mOb4n-dTWsm8RQbWzz4F5iwReC3dzgpjacXGfR8rK2fpvtJ6SKjTczBmLd4VprKynp3vIYmKwoF7ffIPHwhLPrrBvwAE4b0Nmrs9SQRqJHs-aHHRXtZlCsFDeDvFZTLZACemiZtFhzanbYWQ564tnUb2ArxYU1-PfrMf_9mmnkqg3sJ9fQGVV0mvv9bmp3V9YO3rD6H0mMV6AKujZEVvZUrM3CMv3HCGQCbfoy_PZLeVXG4q-JgFMGV6nCPVN7Z1NKa-sCH2gyRVoGDN5cwAPEujoTp4vjdLxvSWQHUVP72EArcsWFnyM3bTLiI09OeddXQt7G8JVpXC2LXXWkbIxZ0NeUwC8m6kwp1P_W2vOj0E0W6SpVLSadwd-pRKOjMJNCk91NSxZA5RVySswvNPuersiXu-CdXRrbxXpa1Z01M7343diE4rBeUyUpvriq5P7_ZHxs6lDnIE27lPPYxtmluJ4uPSIJrZhDRgnwlRZf9RWFdH7t4sTh7vIwfyKxNNyeCSzAOHZCTHjT47ktR6YmzX08ghepJJImdUzVzB9lVkeKGNRiWsx7qDJRrvjtAT2A'
      },
    );
    return await dio
        .patch(
      method,
      data: data,
    );
  }

  static Future<dynamic> deleteData({
    required String method,
    String? token,
  }) async {
    dio.options.headers.addAll(
      {
        "Accept-Language": isArabic() ? 'ar' : 'en',
        'Authorization': 'Bearer $refreshToken',
        'Cookie': '.AspNetCore.Identity.Application=CfDJ8NldnRtlwshNgUlgpQYWpZbEzvA0qYCL5ZDTQe3BIigqH9DKeCOiJTCtqhxHsN7hwECElyaVKF62nyS6FA65t35_9HEYRg3d4bY8AKDVdKAePC5G9GCPRmY6w3PYS8w_ZQvb1PudjLsRFsg3ea6WHoKynxCoWHpgvyU-iR7XK310X9YuR1ehGCCdL7eP6eY_mOb4n-dTWsm8RQbWzz4F5iwReC3dzgpjacXGfR8rK2fpvtJ6SKjTczBmLd4VprKynp3vIYmKwoF7ffIPHwhLPrrBvwAE4b0Nmrs9SQRqJHs-aHHRXtZlCsFDeDvFZTLZACemiZtFhzanbYWQ564tnUb2ArxYU1-PfrMf_9mmnkqg3sJ9fQGVV0mvv9bmp3V9YO3rD6H0mMV6AKujZEVvZUrM3CMv3HCGQCbfoy_PZLeVXG4q-JgFMGV6nCPVN7Z1NKa-sCH2gyRVoGDN5cwAPEujoTp4vjdLxvSWQHUVP72EArcsWFnyM3bTLiI09OeddXQt7G8JVpXC2LXXWkbIxZ0NeUwC8m6kwp1P_W2vOj0E0W6SpVLSadwd-pRKOjMJNCk91NSxZA5RVySswvNPuersiXu-CdXRrbxXpa1Z01M7343diE4rBeUyUpvriq5P7_ZHxs6lDnIE27lPPYxtmluJ4uPSIJrZhDRgnwlRZf9RWFdH7t4sTh7vIwfyKxNNyeCSzAOHZCTHjT47ktR6YmzX08ghepJJImdUzVzB9lVkeKGNRiWsx7qDJRrvjtAT2A'
      },
    );
    return await dio
        .delete(
      method,
    );
  }
}
