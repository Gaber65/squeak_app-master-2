import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
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
      titleTextStyle: getBoldStyle(
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
        textStyle: getRegularStyle(
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
      titleLarge: getBoldStyle(
        fontSize: FontSize.s22,
        color: ColorManager.sBlack,
      ),
      titleMedium: getBoldStyle(
        fontSize: FontSize.s18,
        color: ColorManager.sBlack,
      ),
      titleSmall: getBoldStyle(
        color: ColorManager.sBlack,
        fontSize: FontSize.s16,
      ),
      displayMedium: getRegularStyle(
        color: ColorManager.sBlack,
        fontSize: FontSize.s18,
      ),
      displaySmall: getRegularStyle(
        color: ColorManager.gGrey,
        fontSize: FontSize.s14,
      ),
      bodyMedium: getRegularStyle(
        color: ColorManager.bBlack,
        fontSize: FontSize.s18,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.gGrey,
        fontSize: FontSize.s16,
      ),
      headlineLarge: getRegularStyle(
        color: ColorManager.sBlack,
        fontSize: FontSize.s30,
      ),
      headlineSmall: getRegularStyle(
        color: ColorManager.sBlack,
        fontSize: FontSize.s25,
      ),
    ),
    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorManager.sWhite,
      filled: true,
      border: InputBorder.none,
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      // hint style
      hintStyle: getRegularStyle(
        color: ColorManager.gGrey,
        fontSize: FontSize.s14,
      ),
      labelStyle: getRegularStyle(
        color: ColorManager.gGrey,
        fontSize: FontSize.s14,
      ),
      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s50),
        borderSide: BorderSide.none,
      ),

      // focused border style
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s50),
        borderSide: BorderSide.none,
      ),

      // error border style
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s50),
        borderSide: BorderSide.none,
      ),
      // focused border style
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s50),
        borderSide: BorderSide.none,
      ),
      // label style
    ),
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
      titleTextStyle: getBoldStyle(
        fontSize: FontSize.s18,
        color: ColorManager.sWhite, // It will be changed
        // color: ColorManager.white,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.teal,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: ColorManager.bBlack,
      selectedLabelStyle: TextStyle(color: Colors.teal),
      unselectedItemColor: ColorManager.grey,
      unselectedLabelStyle: TextStyle(color: ColorManager.grey),
      type: BottomNavigationBarType.fixed,
    ),

    primarySwatch: ColorManager.mGreen,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorManager.bBlack,
      elevation: AppSize.s3,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.sWhite,
        textStyle: getRegularStyle(color: ColorManager.sWhite, fontSize: FontSize.s18),
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
      titleLarge: getBoldStyle(
        fontSize: FontSize.s22,
        color: ColorManager.sWhite,
      ),
      titleMedium: getBoldStyle(
        fontSize: FontSize.s18,
        color: ColorManager.sWhite,
      ),
      titleSmall: getBoldStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s16,
      ),
      displayMedium: getRegularStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s18,
      ),
      displaySmall: getRegularStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s14,
      ),
      bodyMedium: getRegularStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s18,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s16,
      ),
      headlineLarge: getRegularStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s30,
      ),
      headlineSmall: getRegularStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s25,
      ),
    ),
    // // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorManager.bBlack,
      filled: true,
      border: InputBorder.none,

      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      // hint style
      hintStyle: getLightStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s14,
      ),
      labelStyle: getRegularStyle(
        color: ColorManager.sWhite,
        fontSize: FontSize.s14,
      ),
      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s50),
        borderSide: BorderSide.none,
      ),

      // focused border style
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s50),
        borderSide: BorderSide.none,
      ),

      // error border style
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s50),
        borderSide: BorderSide.none,
      ),
      // focused border style
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s50),
        borderSide: BorderSide.none,
      ),
      // label style
    ),
  );
}
