import 'package:animate_do/animate_do.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/widgets/components/styles.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 400),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade700,
        highlightColor: Colors.grey.shade600,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Directionality(
            textDirection: isArabic() ? TextDirection.rtl : TextDirection.ltr,

            child: CommentTreeWidget<Comment, Comment>(
              Comment(
                  avatar:
                  'https://img.freepik.com/premium-vector/people-communication-icon-comic-style-people-vector-cartoon-illustration-pictogram-partnership-business-concept-splash-effect_157943-6552.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                  userName: 'null',
                  content: 'felangel made felangel/cubit_and_beyond public '),
              [
                Comment(
                    avatar:
                    'https://img.freepik.com/premium-vector/people-communication-icon-comic-style-people-vector-cartoon-illustration-pictogram-partnership-business-concept-splash-effect_157943-6552.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                    userName: 'null',
                    content: 'A Dart template generator which helps teams'),
                Comment(
                    avatar:
                    'https://img.freepik.com/premium-vector/people-communication-icon-comic-style-people-vector-cartoon-illustration-pictogram-partnership-business-concept-splash-effect_157943-6552.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                    userName: 'null',
                    content: 'A Dart template generator which helps teams'),
                Comment(
                    avatar:
                    'https://img.freepik.com/premium-vector/people-communication-icon-comic-style-people-vector-cartoon-illustration-pictogram-partnership-business-concept-splash-effect_157943-6552.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                    userName: 'null',
                    content: 'A Dart template generator which helps teams'),
                Comment(
                    avatar:
                    'https://img.freepik.com/premium-vector/people-communication-icon-comic-style-people-vector-cartoon-illustration-pictogram-partnership-business-concept-splash-effect_157943-6552.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                    userName: 'null',
                    content:
                    'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
                Comment(
                    avatar:
                    'https://img.freepik.com/premium-vector/people-communication-icon-comic-style-people-vector-cartoon-illustration-pictogram-partnership-business-concept-splash-effect_157943-6552.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                    userName: 'null',
                    content: 'A Dart template generator which helps teams'),
                Comment(
                    avatar:
                    'https://img.freepik.com/premium-vector/people-communication-icon-comic-style-people-vector-cartoon-illustration-pictogram-partnership-business-concept-splash-effect_157943-6552.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                    userName: 'null',
                    content:
                    'A Dart template generator which helps teams generator which helps teams '),

              ],
              treeThemeData: TreeThemeData(
                lineColor: appColorBtn!,
                lineWidth: 1,
              ),
              avatarRoot: (context, data) => const PreferredSize(
                preferredSize: Size.fromRadius(18),
                child: Row(),
              ),
              avatarChild: (context, data) => const PreferredSize(
                preferredSize: Size.fromRadius(12),
                child: Row(),
              ),
              contentChild: (context, data) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Gaber',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                                fontWeight: FontWeight.w600, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${data.content}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w300, color: Colors.black),
                      ),
                    ],
                  ),
                );
              },
              contentRoot: (context, data) {
                return const Column();
              },
            ),
          ),
        ),
      ),
    );
  }
}
