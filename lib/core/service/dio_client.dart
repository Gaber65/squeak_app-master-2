import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/service/server_error.dart';
import 'dart:convert';

import 'package:squeak/core/service/service_locator.dart';



class DioClient {
  static String ApiKey = "00000000";
  static  String lang = sl<SharedPreferences>().getString('language')!= null?sl<SharedPreferences>().getString('language')!:"en";
  static late final Dio _dio = Dio(

  );

  static Future<Either<ServerError, Response>> PostData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _dio.options.headers = {
      "api-key": ApiKey,
      "lang":lang ,
      // 'Content-Type': 'application/json',
      "Authorization": token,
    };
    try {
      final response = await _dio.patch(
        queryParameters: query,
        url,
        data: data,
        // options: Options(followRedirects: false, validateStatus: (status) {return status! < 200;}),
      );
      return Right(response);
    }   on DioError catch (e) {
      final body;
      try {
        body = json.decode(e.response.toString());
      }
      catch (e) {
        return Left(
          ServerError(title: "Something Went Wrong", status: 500),
        );
      }
      return Left(
        ServerError(
            title: "${body["message"]}", status: e.response!.statusCode),
      );
    }
    catch (e) {
      return Left(
        ServerError(title: "Something Went Wrong", status: 500),
      );
    }
  }

  static Future<Either<ServerError, Response>> postFormData({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _dio.options.headers = {
      "api-key": ApiKey,
      "lang":lang ,
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    try {
      final response = await _dio.post(
        url,
        data: data,
      );
      return Right(response);
    }  on DioError catch (e) {
      final  body;
      try {
        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

        body = json.decode(e.response.toString());
      }
      catch (e) {
        return Left(
          ServerError(title: "Something Went Wrong", status: 500),
        );
      }
      print(body.toString());
      return Left(

        ServerError(
            title: "${body["errors"]}", status: e.response!.statusCode),
      );
    }
    catch (e) {
      return Left(
        ServerError(title: "Something Went Wrong", status: 500),
      );
    }
  }

  static Future<Either<ServerError, Response>> putFormData({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
    String? token,
  }) async {

    print("ggggggggggggggggggggggggggg$token");
    print("ggggggggggggggggggggggggggg$url");
    // String str=utf8.decode(await data.readAsBytes(),allowMalformed: true);

    // print("ggggggggggggggggggggggggggg$str");

    try {
      _dio.options.headers = {
        "lang":lang ,
        'Authorization': token,
      };

      final response = await _dio.put(


        url,

        data: data,
      );
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");

      print(response.toString());

      return Right(response);
    }   on DioError catch (e) {
      final body;
      try {
        body = json.decode(e.response.toString());
print(body);
      }
      catch (e) {
        return Left(
          ServerError(title: "Something Went Wrong", status: 500),
        );
      }     return Left(
        ServerError(
            title: "${body["message"]}", status: e.response!.statusCode),
      );
    }
    catch (e) {
      return Left(
        ServerError(title: "Something Went Wrong", status: 500),
      );
    }
  }

  static Future<Either<ServerError, Response>> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      "Authorization":  token,
      "api-key": ApiKey,"lang":lang ,
    };
   try{
      final response = await _dio.get(url, queryParameters: query);
      return  Right(response);
  }
    on DioError catch (e) {
      final body;
      try {
     body = json.decode(e.response.toString());
    }
      catch (e) {
        return Left(
          ServerError(title: "Something Went Wrong", status: 500),
        );
      }     return Left(
        ServerError(
            title: "${body["message"]}", status: e.response!.statusCode),
      );
    }
    catch (e) {
      return Left(
        ServerError(title: "Something Went Wrong", status: 500),
      );
    }
  }

  static Future<Either<ServerError, Response>> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _dio.options.headers = {
      "api-key": ApiKey,"lang":lang ,
      'Content-Type': 'application/json',
      // 'token': token,
      "Authorization":  token,
    };
    try {
      final response = await _dio.delete(url, queryParameters: query);
      return Right(response);
    }  on DioError catch (e) {
      final body;
      try {
        body = json.decode(e.response.toString());
      }
      catch (e) {
        return Left(
          ServerError(title: "Something Went Wrong", status: 500),
        );
      }     return Left(
        ServerError(
            title: "${body["message"]}", status: e.response!.statusCode),
      );
    }
    catch (e) {
      return Left(
        ServerError(title: "Something Went Wrong", status: 500),
      );
    }
  }

  static Future<Either<ServerError, Response>> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {


    _dio.options.headers = {
      "api-key": ApiKey,"lang":lang ,
      "Authorization":  token,
    };
    dynamic x;
    try {
      final response = await _dio.post(
        url,
        data: data,
      );
      x = response;
      return Right(response);
    }   on DioError catch (e) {
      final body;
      try {
        body = json.decode(e.response.toString());
      }
      catch (e) {
        return Left(
          ServerError(title: "Something Went Wrong", status: 500),
        );
      }

      return Left(
        ServerError(
            title: "${body["message"]}", status: e.response!.statusCode),
      );
    }
    catch (e) {
      return Left(
        ServerError(title: "Something Went Wrong", status: 500),
      );
    }
  }

  static Future<Either<ServerError, Response>> postData2({
    required String url,
    var data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _dio.options.headers = {
      "api-key": ApiKey,"lang":lang ,

      "Authorization":  token,
    };
    dynamic x;
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode(data),
      );
      x = response;
      return Right(response);
    }   on DioError catch (e) {
      final body;
      try {
        body = json.decode(e.response.toString());
      }
      catch (e) {
        return Left(
          ServerError(title: "Something Went Wrong", status: 500),
        );
      }     return Left(
        ServerError(
            title: "${body["message"]}", status: e.response!.statusCode),
      );
    }
    catch (e) {
      return Left(
        ServerError(title: "Something Went Wrong", status: 500),
      );
    }
}


}
