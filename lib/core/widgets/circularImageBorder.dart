import 'dart:io';

import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class circularImageBorderCustom extends StatefulWidget {
  String image;
  double leftMargin;
  double topMargin;
  double rightMargin;
  double bottomMargin;
  double height;
  double width;
  double raduis;
  String? defultImage;
  double? borderwidth;
  BoxFit boxfit;
  Colors? color;
  circularImageBorderCustom(
      {

        required this.image,
      required this.raduis,
      required this.width,
      required this.height,
      required this.bottomMargin,
      required this.leftMargin,
      required this.rightMargin,
      required this.topMargin,
      required this.boxfit,
        this.borderwidth,
        this.defultImage,
      this.color});

  @override
  _circularImageBorderCustomState createState() =>
      _circularImageBorderCustomState();
}

class _circularImageBorderCustomState extends State<circularImageBorderCustom> {
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        width: widget.width,
        height: widget.height,
        child: Card(
          margin: EdgeInsets.only(
              left: widget.leftMargin,
              right: widget.rightMargin,
              top: widget.topMargin,
              bottom: widget.bottomMargin),
          elevation: 15,
          shadowColor: Colors.black.withOpacity(.20),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorManager.sWhite, width:widget. borderwidth??1),
            borderRadius: BorderRadius.circular(10),
          ),
          child:

    ClipRRect(
          borderRadius: BorderRadius.circular(widget.raduis),
          child: Image.network(
            errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {

            return   Center(child:  Stack(
              children: [
                Image.asset(
                    "assets/images/pet.jpg"
                ),
              ],
            ),);
          },
            width: widget.width,
            height: widget.height,
            widget.image,
            fit: widget.boxfit,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
    ),
      );
  }
}


class circularImageBorderAssetsCustom extends StatefulWidget {
  String image;
  double leftMargin;
  double topMargin;
  double rightMargin;
  double bottomMargin;
  double height;
  double width;
  double raduis;
  String? defultImage;
  double? borderwidth;
  BoxFit boxfit;
  Colors? color;
  circularImageBorderAssetsCustom(
      {

        required this.image,
      required this.raduis,
      required this.width,
      required this.height,
      required this.bottomMargin,
      required this.leftMargin,
      required this.rightMargin,
      required this.topMargin,
      required this.boxfit,
        this.borderwidth,
        this.defultImage,
      this.color});

  @override
  _circularImageBorderAssetsCustomState createState() =>
      _circularImageBorderAssetsCustomState();
}

class _circularImageBorderAssetsCustomState extends State<circularImageBorderAssetsCustom> {
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        width: widget.width,
        height: widget.height,
        child: Card(
          margin: EdgeInsets.only(
              left: widget.leftMargin,
              right: widget.rightMargin,
              top: widget.topMargin,
              bottom: widget.bottomMargin),
          elevation: 15,
          shadowColor: Colors.black.withOpacity(.20),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorManager.sWhite, width:widget. borderwidth??1),
            borderRadius: BorderRadius.circular(10),
          ),


          child:
          Image.asset(
            width: widget.width,
            height: widget.height,
            widget.image,
            fit: widget.boxfit,


        ),
    ),
      );
  }
}

class circularImageBorderCustomWithColor extends StatefulWidget {
  String image;
  double leftMargin;
  double topMargin;
  double rightMargin;
  double bottomMargin;
  double height;
  double width;
  double raduis;
  BoxFit boxfit;
  Color color;

  circularImageBorderCustomWithColor(
      {required this.image,
      required this.raduis,
      required this.width,
      required this.height,
      required this.bottomMargin,
      required this.leftMargin,
      required this.rightMargin,
      required this.topMargin,
      required this.boxfit,
      required this.color});

  @override
  _circularImageBorderCustomStateWithColor createState() =>
      _circularImageBorderCustomStateWithColor();
}

class _circularImageBorderCustomStateWithColor
    extends State<circularImageBorderCustomWithColor> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
          margin: EdgeInsets.only(
              left: widget.leftMargin,
              right: widget.rightMargin,
              top: widget.topMargin,
              bottom: widget.bottomMargin),
          elevation: 15,
          shadowColor: Colors.black.withOpacity(.20),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorManager.sWhite, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(
              //   color: widget.color,
              //   width: 1,
              // ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.raduis),
              child: Image.network(         errorBuilder:
                  (BuildContext context, Object exception, StackTrace? stackTrace) {

                return   Center(child:    Stack(
                  children: [
                    Image.asset(
                      ""
                  ),
                  ],
                ),);
              },
                widget.image,
                fit: widget.boxfit,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          )),
    );
  }
}

class circularImageBorderCustomfile extends StatefulWidget {
  File image;
  double leftMargin;
  double topMargin;
  double rightMargin;
  double bottomMargin;
  double height;
  double width;
  double raduis;
  BoxFit boxfit;

  circularImageBorderCustomfile(
      {required this.image,
      required this.raduis,
      required this.width,
      required this.height,
      required this.bottomMargin,
      required this.leftMargin,
      required this.rightMargin,
      required this.topMargin,
      required this.boxfit});

  @override
  _circularImageBorderCustomfile createState() =>
      _circularImageBorderCustomfile();
}

class _circularImageBorderCustomfile
    extends State<circularImageBorderCustomfile> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(
            left: widget.leftMargin,
            right: widget.rightMargin,
            top: widget.topMargin,
            bottom: widget.bottomMargin),
        elevation: 15,
        shadowColor: Colors.black.withOpacity(.10),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorManager.sWhite, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: widget.width,
          height: widget.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.raduis),
            child: Image.file(
              widget.image,
              fit: widget.boxfit,
            ),
          ),
        ));
  }
}
