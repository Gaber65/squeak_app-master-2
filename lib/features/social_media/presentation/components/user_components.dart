import 'package:flutter/material.dart';

import '../../../../core/widgets/components/styles.dart';
import '../screens/chat.dart';

Widget buildDoctorData(context, name, image) {
  return GestureDetector(
    onTap: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ChatDetail(
      //       name: name,
      //       image: image,
      //     ),
      //   ),
      // );
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: appColorBtn,
          radius: 30,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              image,
            ),
            radius: 29,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'medium',
                  fontSize: 14,
                ),
              ),
              Text('Lets play cricket tournament lorem ipsum',
              style: TextStyle(
                fontSize: 14
              ),
              ),
            ],
          ),
        ),
        Text(
          '20 mins',
          style: TextStyle(
              fontSize: 14
          ),
        ),
      ],
    ),
  );
}
