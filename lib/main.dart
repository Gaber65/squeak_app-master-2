import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/helper/helper_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/home/home.dart';

import 'package:squeak/generated/l10n.dart';

import 'core/main_basic/main_basic.dart';
import 'core/network/end-points.dart';

import 'core/network/helper/connect/internet__cubit.dart';
import 'core/resources/theme_manager.dart';
import 'core/service/service_locator.dart';

import 'features/authentication/login/presentation/pages/login.dart';

import 'features/availability/presentation/control/appointments/appointments_cubit.dart';
import 'features/layout/build_layout.dart';

import 'features/layout/layout.dart';
import 'features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'features/layout/presentation/controller/notification_cubit/notification_cubit.dart';
import 'features/layout/presentation/controller/post_cubit/post_cubit.dart';
import 'features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import 'features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import 'features/setting/update_profile/presentation/controlls/cubit/beets_type_find_states.dart';
import 'features/social_media/presentation/controller/phone_cubit/phone_cubit.dart';

void main() async {
  ///todo Basic
  await mainBasic();
  await shareApp();
  print(sl<SharedPreferences>().getString('token'));

  ///todo Home Rout
  Widget widget;
  if (token != '') {
    widget = const LayoutScreen();
  } else {
    widget = LoginScreen();
  }

  runApp(
    MyApp(
      startWidget: widget!,
      isDark: sl<SharedPreferences>().getBool('isDark') ?? false,
      language: sl<SharedPreferences>().getString('language') ?? 'en',
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  final bool isDark;
  String language;

  MyApp({
    Key? key,
    required this.startWidget,
    required this.isDark,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale? myLocale;
    return MultiBlocProvider(
      providers: [
        ///todo post cubit
        BlocProvider(
          create: (context) {
            return sl<PostCubit>()..getAllUserPost();
          },
        ),

        ///todo SqueakCubit
        BlocProvider(
          create: (context) {
            return sl<SqueakCubit>()
              ..getOwnerPits()
              ..getProfile();
          },
        ),

        ///todo NotificationCubit

        BlocProvider(
          create: (context) {
            return sl<NotificationCubit>()..getNotification();
          },
        ),

        ///todo PhoneCubit
        BlocProvider(
          create: (context) {
            return sl<PhoneCubit>()..getUserData();
          },
        ),

        ///todo AppointmentsCubit

        BlocProvider(
          create: (context) {
            return sl<AppointmentsCubit>()..getAppointments();
          },
        ),

        ///todo ClinicCubit

        BlocProvider(
          create: (context) {
            return sl<ClinicCubit>()..geMyFollowerClinic();
          },
        ),

        BlocProvider(
          create: (BuildContext context) {
            return sl<BreedsTypeCubit>()
              ..changeAppMode(fromShared: isDark)
              ..changeAppLang(fromSharedLang: language);
          },
        ),

        BlocProvider(
          create: (context) => InternetCubit(),
        ),
      ],
      child: BlocConsumer<BreedsTypeCubit, BreedTypeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BreedsTypeCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationLightTheme(),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: getApplicationDarkTheme(),
            locale: cubit.language == 'en'
                ? const Locale('en')
                : const Locale('ar'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              myLocale = deviceLocale;
              language = myLocale!.languageCode;
              return myLocale;
            },
            home: startWidget!,
          );
        },
      ),
    );
  }
}
