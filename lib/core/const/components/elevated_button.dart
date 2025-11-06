import 'package:flutter/material.dart';
import 'package:mostakbal/core/const/const.dart';

class MyElevatedButton extends StatelessWidget {
  final double height;
  final VoidCallback? onPressed;
  final String text;

  final Color? primary;
  final Color? fontColor;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.primary,
    this.fontColor,
    this.height = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ?? ColorStyle().primaryColor,
          shape: (
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
          ),
        ),
        child: Text(
          text,
          style: FontStyle().textStyle(
            fontColor: fontColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}

class TextFormWidget extends StatefulWidget {
  TextFormWidget(
      {super.key,
      required this.emailController,
      required this.prefixIcon,
      required this.hintText,
      required this.validator,
      required this.obscureText,
      required this.icon,
      this.suffixIcon,
      this.enabled});

  final TextEditingController emailController;
  final Widget prefixIcon;
  final String hintText;
  final String validator;
  bool obscureText;
  bool? enabled = true;
  bool icon;
  Widget? suffixIcon;

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(242, 242, 242, 1),
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        cursorColor: Colors.blue,
        enabled: widget.enabled,
        controller: widget.emailController,
        keyboardType: TextInputType.emailAddress,
        obscureText: widget.obscureText,
        validator: (String? value) {
          if (value!.isEmpty) {
            return widget.validator;
          }
          return null;
        },
        keyboardAppearance: Brightness.dark,
        decoration: InputDecoration(
            hintText: widget.hintText,
            labelStyle: const TextStyle(fontSize: 20, color: Colors.grey),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.icon
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                    icon: widget.obscureText
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.visibility_off_outlined),
                  )
                : null,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none),
      ),
    );
  }
}
