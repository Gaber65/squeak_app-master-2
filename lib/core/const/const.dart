import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constant {
  ///todo fireBase init
  final String apiKey = 'AIzaSyAIDgJeKXayEcqzjlYPatFoHYKLWZT3IJ4';
  final String appId = '1:954979019057:android:5446aaf0259b280fde6810';
  final String messagingSenderId = '954979019057';
  final String projectId = 'mostakbal-acd29';

  /// todo share reference
    String uId = '';
}

class RoutePage {
  void navigateAndRemove(context, widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
  }

  void navigateTo(context, widget) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );
}

class FontStyle {

  TextStyle textStyle({
    double fontSize = 20,
    Color fontColor = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.tajawal(
      color: fontColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }
}

class ColorStyle {
  Color primaryColor = const Color.fromRGBO(13, 110, 253, 1);
  Color secondColor = const Color.fromRGBO(255, 112, 41, 1);
}
