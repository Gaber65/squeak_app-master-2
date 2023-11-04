import 'package:flutter/material.dart';
import 'package:squeak/core/widgets/components/styles.dart';

class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final FormFieldValidator<String>? validator;
  final double radius;
  final String label;
  final bool isUpperCase;
  //final IconData prefix;
  final Function()? onPressed;
  final Widget? suffix;
  final bool? enable;
  final ValueChanged<String>? onChanged;
  final bool isPassword;
  final bool showIcon;
  Color? fillColor = Colors.transparent;
  MyFormField(
      {Key? key,
      required this.controller,
      required this.type,
      this.radius = 10.0,
      required this.label,
      this.isUpperCase = true,
      //required this.prefix,
      this.suffix,
      this.enable,
      required this.validator,
      this.onPressed,
      this.isPassword = false,
      this.onChanged,
      this.showIcon = false,
      this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validator,
      obscureText: isPassword,
      enabled: enable,
      onChanged: onChanged,
      onFieldSubmitted: onChanged,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffix,
        fillColor: fillColor,
        labelStyle: FontStyle().textStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.normal
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
      ),
    );
  }
}
