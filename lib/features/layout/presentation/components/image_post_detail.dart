import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../comment/presentation/pages/comment.dart';

class ImagePostDetail extends StatelessWidget {
  ImagePostDetail({Key? key, required this.image ,required this.title}) : super(key: key);
  String image;
  String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CachedNetworkImage(
          width: double.infinity,
          fit: BoxFit.contain,
          imageUrl: image,
        ),
      ),
    );
  }
}
