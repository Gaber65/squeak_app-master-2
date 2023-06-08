import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:squeak/features/layout/cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/layout.dart';

import 'core/network/end-points.dart';
import 'core/observer/observer.dart';
import 'core/resources/theme_manager.dart';
import 'core/service/service_locator.dart';
import 'core/utils/translation/applocal.dart';
import 'features/authentication/login/presentation/pages/login.dart';
import 'features/layout/update_profile/cubit/beets_type_find_cubit.dart';
import 'features/layout/update_profile/cubit/add_edit_beets_cubit.dart';
import 'features/layout/update_profile/cubit/beets_type_find_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init();
  Bloc.observer = MyBlocObserver();
  token = sl<SharedPreferences>().getString('token');
  String? lang = sl<SharedPreferences>().getString('language');
  lang != null ? language = lang : language = 'en';
  Widget widget;

  if (token != null) {
    widget = const LayoutScreen();
  } else {
    widget = const LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale? myLocale;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => BeedstypeCubit()),
        BlocProvider(create: (BuildContext context) => AddBeetsCubit()),
        BlocProvider(
          create: (BuildContext context) => sl<SqueakCubit>()
            ..getOwnerPits()
            ..getProfile(),
        ),
      ],
      child: BlocConsumer<BeedstypeCubit, BreedTypeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationLightTheme(),
            localizationsDelegates: const [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("en", ""),
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              myLocale =
                  deviceLocale; // here you make your app language similar to device language , but you should check whether the localization is supported by your app
              language = myLocale!.languageCode;
              print("ddddddddddddddddd$language");
              return myLocale;
            },
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
