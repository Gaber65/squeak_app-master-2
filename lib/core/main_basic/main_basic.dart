import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../features/authentication/login/presentation/pages/login.dart';
import '../../../features/layout/build_layout.dart';

import 'package:intl/intl.dart';

import '../../features/social_media/presentation/components/chat_hub_connection.dart';
import '../network/dio.dart';
import '../network/end-points.dart';
import 'observer.dart';
import '../service/secand_sevice_locator.dart';
import '../service/service_locator.dart';
import '../widgets/components/hub_connection.dart';
import '../widgets/components/notifi_service.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

///todo SharedPreferences

Future<void> shareApp() async {
  token = sl<SharedPreferences>().getString('token') ?? '';
  clintId = sl<SharedPreferences>().getString('clintId') ?? '';
  refreshToken = sl<SharedPreferences>().getString('refreshToken') ?? '';
  uId = sl<SharedPreferences>().getString('uId') ?? '';
  language = sl<SharedPreferences>().getString('language') ?? '';
}

Future<void> mainBasic() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator().init();
  await ServiceSecondLocator().init();
  Bloc.observer = await MyBlocObserver();
  await Firebase.initializeApp();
  DioFinalHelper.init();
  await initNotifications();


  HttpOverrides.global = new PostHttpOverrides();
}

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
