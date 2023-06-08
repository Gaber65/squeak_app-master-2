import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({Key? key}) : super(key: key);
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                    'https://img.freepik.com/free-photo/front-view-man-with-cute-greyhound-dog_23-2150231834.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=sph',
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only( left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Gaber Abdelrheem gaber"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: const Text(
                                " اتقو يوم ترجعون فيه إلى الله",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '2 h',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          child: Text(
                            'Like',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          child: Text(
                            'Reply',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            commentController.buildTextSpan(
                                context: context,
                                withComposing: bool.hasEnvironment('name'));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                focusColor: Colors.red,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.near_me,
                    size: 16,
                  ),
                ),
                label: const Text(
                  'Add Your Comment . . . ',
                  style: TextStyle(fontFamily: 'bold', color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(.4))),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(.4))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(.4))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
