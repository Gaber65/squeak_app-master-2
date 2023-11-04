import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationLightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.sWhite,
    // app bar theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: true,
      backgroundColor: ColorManager.sWhite,
      iconTheme: const IconThemeData(
        color: ColorManager.sBlack,
      ),
      elevation: AppSize.s0,
      titleTextStyle: FontStyle().textStyle(
        fontSize: FontSize.s18,
        color: ColorManager.sBlack, // It will be changed
        // color: ColorManager.black,
      ),
    ),

    sliderTheme: const SliderThemeData(
      valueIndicatorTextStyle: TextStyle(
        color: ColorManager.sWhite,
      ),
    ),

    primarySwatch: Colors.red,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorManager.sWhite,
      elevation: AppSize.s3,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.sBlack,
        textStyle: FontStyle().textStyle(
          color: ColorManager.sBlack,
          fontSize: FontSize.s18,
        ),
      ),
    ),

    cardColor: ColorManager.sWhite,

    iconTheme: const IconThemeData(
      color: ColorManager.sBlack,
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: ColorManager.sBlack,
      textColor: ColorManager.sBlack,
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: ColorManager.sWhite,
    ),
    //BottomNavigationBarTheme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ColorManager.lightRed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: ColorManager.sWhite,
      selectedLabelStyle: TextStyle(color: Colors.teal),
      unselectedItemColor: ColorManager.grey,
      unselectedLabelStyle: TextStyle(
        color: ColorManager.grey,
      ),
      type: BottomNavigationBarType.fixed,
    ),

    // _______/ It will be updated \_________________________
    textTheme: TextTheme(
      titleLarge: FontStyle().textStyle(
        fontSize: FontSize.s22,
        color: ColorManager.sBlack,
      ),
      titleMedium: FontStyle().textStyle(
        fontSize: FontSize.s18,
        color: ColorManager.sBlack,
      ),
      titleSmall: FontStyle().textStyle(
        color: ColorManager.sBlack,
        fontSize: FontSize.s16,
      ),
      displayMedium: FontStyle().textStyle(
        color: ColorManager.sBlack,
        fontSize: FontSize.s18,
      ),
      displaySmall: FontStyle().textStyle(
        color: ColorManager.gGrey,
        fontSize: FontSize.s14,
      ),
      bodyMedium: FontStyle().textStyle(
        color: ColorManager.bBlack,
        fontSize: FontSize.s18,
      ),
      bodySmall: FontStyle().textStyle(
        color: ColorManager.gGrey,
        fontSize: FontSize.s16,
      ),
      headlineLarge: FontStyle().textStyle(
        color: ColorManager.sBlack,
        fontSize: FontSize.s30,
      ),
      headlineSmall: FontStyle().textStyle(
        color: ColorManager.sBlack,
        fontSize: FontSize.s25,
      ),
    ),
    // input decoration theme (text form field)
  );
}

ThemeData getApplicationDarkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.sBlack,
    // app bar theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      centerTitle: true,
      backgroundColor: ColorManager.sBlack,
      iconTheme: const IconThemeData(color: ColorManager.sWhite),
      elevation: AppSize.s0,
      titleTextStyle: FontStyle().textStyle(
        fontSize: FontSize.s18,
        fontWeight: FontWeight.bold,
        color: ColorManager.sWhite, // It will be changed
        // color: ColorManager.white,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: appColorBtn,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: ColorManager.bBlack,
      selectedLabelStyle: TextStyle(color: Colors.teal),
      unselectedItemColor: ColorManager.grey,
      unselectedLabelStyle: TextStyle(color: ColorManager.grey),
      type: BottomNavigationBarType.fixed,
    ),

    primarySwatch: Colors.red,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorManager.bBlack,
      elevation: AppSize.s3,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.sWhite,
        textStyle: FontStyle()
            .textStyle(color: ColorManager.sWhite, fontSize: FontSize.s18),
      ),
    ),

    sliderTheme: const SliderThemeData(
      valueIndicatorTextStyle: TextStyle(
        color: ColorManager.sWhite,
      ),
    ),

    cardColor: ColorManager.bBlack,

    listTileTheme: const ListTileThemeData(
      iconColor: ColorManager.sWhite,
      textColor: ColorManager.sWhite,
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: ColorManager.sBlack,
    ),

    iconTheme: const IconThemeData(
      color: ColorManager.sWhite,
    ),

    textTheme: TextTheme(
      titleLarge: FontStyle().textStyle(
        fontSize: FontSize.s22,
        color: ColorManager.sWhite,
      ),
      titleMedium: FontStyle().textStyle(
        fontSize: FontSize.s18,
        color: ColorManager.sWhite,
      ),
      titleSmall: FontStyle().textStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s16,
      ),
      displayMedium: FontStyle().textStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s18,
      ),
      displaySmall: FontStyle().textStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s14,
      ),
      bodyMedium: FontStyle().textStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s18,
      ),
      bodySmall: FontStyle().textStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s16,
      ),
      headlineLarge: FontStyle().textStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s30,
      ),
      headlineSmall: FontStyle().textStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s25,
      ),
    ),
  );
}
