import 'dart:io';

import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:squeak/core/widgets/components/notifi_service.dart';

import '../../../../core/network/end-points.dart';
import '../../../../core/service/service_locator.dart';


class ChatNotifications {
  Future<void> initPlatformDartServer() async {
    Future<String> tokenKey() async {
      return '${sl<SharedPreferences>().getString('refreshToken')}';
    }

    final connection = HubConnectionBuilder()
        .withUrl(
      '$baseApiUrl/chathub',
      HttpConnectionOptions(
        logging: (level, message) => print(message),
        accessTokenFactory: tokenKey,
        client: IOClient(
          HttpClient()
            ..badCertificateCallback = (
                x,
                y,
                z,
                ) =>
            true,
        ),
        logMessageContent: true,
        withCredentials: true,
      ),
    )
        .withAutomaticReconnect()
        .build();

    await connection.start();

    connection.onclose((exception) {
      initPlatformDartServer();
    });
    connection.onreconnecting((exception) {
      print(exception);
    });
    connection.on(
      "ReceiveMessage",
          (arguments) {
        print('************${arguments![0]}*********');
        print('************${arguments[1]}*********');
        print('************${arguments[2]}*********');
        scheduleMarchNotification(
          title: arguments[0],
          body: arguments[2],
        );
      },
    );
  }
}
