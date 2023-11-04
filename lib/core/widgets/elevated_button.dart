import 'package:flutter/material.dart';

import 'components/styles.dart';

class MyElevatedButton extends StatelessWidget {
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final text;
  final colors;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.colors,
    this.height = 50.0,
    this.gradient = const LinearGradient(colors: [appColor, appColor2]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: colors,
          onPrimary: Colors.white,
          shadowColor: appColor,
          elevation: 3,
          shape: (RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
        ),
        child: Text(
          text,
          style: TextStyle(fontFamily: 'medium'),
        ),
      ),
    );
  }
}
