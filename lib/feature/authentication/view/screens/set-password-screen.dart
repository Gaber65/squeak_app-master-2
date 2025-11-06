import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/const/components/elevated_button.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/authentication/view/screens/set-password2.dart';

import 'accept-phone-screen.dart';

class SetPasswordScreen extends StatefulWidget {
  SetPasswordScreen({Key? key, required this.email, required this.phone})
      : super(key: key);

  String phone;
  String email;
  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  int _selectedContainer = 0;
  Color _buttonColor = Colors.grey;

  List<Color> _containerColors = [
    Colors.grey.shade100,
    Colors.grey.shade100,
  ];

  bool isClick = false;
  List<Color> _textColors = [
    Colors.black,
    Colors.black,
  ];

  List<Color> _avatarColors = [
    Colors.grey.shade200,
    Colors.grey.shade200,
  ];

  void _changeColorOnTap(int index) {
    setState(() {
      _selectedContainer = index;
      _containerColors[index] = ColorStyle().primaryColor;
      _textColors[index] = Colors.white;
      _avatarColors[index] = Colors.white;

      for (int i = 0; i < _containerColors.length; i++) {
        if (i != index) {
          _containerColors[i] = Colors.grey.shade100;
          _textColors[i] = Colors.black;
          _avatarColors[i] = Colors.grey.shade200;
          _buttonColor = Colors.blue;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'نسيت كلمه المرور',
              style: GoogleFonts.tajawal(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              ' اختر الطريقة التى تود إعادة تعيين كلمة المرور من خلالها ',
              style: GoogleFonts.tajawal(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isClick = !isClick;
              });
              if (isClick) {
                _changeColorOnTap(0);
              } else {
                _changeColorOnTap(1);
              }
              print(isClick);
            },
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: _containerColors[0],
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: _avatarColors[0],
                      child: Icon(IconlyLight.chat),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'عن طريق smsالي رقم الهاتف',
                            style: GoogleFonts.arsenal(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: _textColors[0],
                            ),
                          ),
                          Text(
                            widget.phone,
                            style: GoogleFonts.arsenal(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: _textColors[0],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isClick = !isClick;
              });
              if (isClick) {
                _changeColorOnTap(0);
              } else {
                _changeColorOnTap(1);
                print(isClick);
              }
            },
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: _containerColors[1],
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: _avatarColors[1],
                      child: Icon(IconlyLight.message),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'عن طريق البريد الالكتروني',
                            style: GoogleFonts.arsenal(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: _textColors[1],
                            ),
                          ),
                          Text(
                            widget.email,
                            style: GoogleFonts.arsenal(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: _textColors[1],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          MyElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return VeificationScreen();
              }));
            },            text: 'متابعة',
          ),
        ],
      ),
    ));
  }
}
