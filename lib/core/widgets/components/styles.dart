import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const appColor = Color(0xFFFFA688);
const appColor2 = Color(0xFF272D69);
const appColorBtn = Color(0xFFEF5859);

const backgroundColor = Color.fromARGB(255, 243, 243, 243);

blackHeading(val) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      val,
      style: const TextStyle(
          fontSize: 24, fontFamily: 'bold', color: Colors.black),
    ),
  );
}

blackText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 14, color: Colors.black),
  );
}

blackBoldText(val) {
  return Text(
    val,
    style:
        const TextStyle(fontSize: 18, fontFamily: 'bold', color: Colors.black),
  );
}

greyText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 14, color: Colors.black54),
  );
}

greyTextSmall(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 12, color: Colors.black54),
  );
}

smallText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 10, color: Colors.black54),
  );
}

textField(hint, icn, TextEditingController? controller, validator,
    {int maxLines = 1,
    Function()? onPressed,
    IconData? prefix,
    bool obscureText = false,
    bool enabled = true,
    String? hintText}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return validator;
        }
        return null;
      },
      maxLines: maxLines,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: hint,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 12),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icn,
            size: 18,
          ),
        ),
        labelStyle: const TextStyle(
          fontSize: 12,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: appColor,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: appColor,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: appColor,
          ),
        ),
      ),
    ),
  );
}

class FontStyle {
  TextStyle textStyle({
    double fontSize = 16,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.ubuntu(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }
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

