import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/features/comment/date/model/get_comment_model.dart';
import 'package:squeak/features/comment/presentation/controller/comment_cubit.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import 'package:squeak/features/comment/presentation/components/build_edit_comment.dart';

import '../../../../core/network/end-points.dart';
import '../../../../core/network/helper/helper_cubit.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/widgets/components/styles.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/get_comment_post.dart';
import '../pages/comment_reply.dart';

class SuccessComment extends StatelessWidget {
  SuccessComment({
    super.key,
    required this.scaffoldKey,
    required this.comments,
    required this.commentController,
  });
  final GlobalKey<ScaffoldState> scaffoldKey;
  List<Comments> comments;
  TextEditingController commentController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: CommentTreeWidget<Comments, Comments>(
          const Comments(
            id: 'id',
            content: 'content',
            image: 'image',
            userId: 'userId',
            postId: 'postId',
            user: null,
            post: null,
          ),
          comments,
          treeThemeData: TreeThemeData(
            lineColor: appColorBtn!,
            lineWidth: 1,
          ),
          avatarRoot: (context, data) => const PreferredSize(
            preferredSize: Size.fromRadius(18),
            child: Row(),
          ),
          avatarChild: (context, data) => PreferredSize(
            preferredSize: Size.fromRadius(12),
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                data.pet == null
                    ? "$imageUrl${data.user!.imageName}"
                    : "$imageUrl${data.pet!.imageName}",
              ),
            ),
          ),
          contentChild: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onLongPress: () {
                    print(sl<SharedPreferences>().getString('clintId'));
                    print(data.userId);
                    if (data.userId ==
                        sl<SharedPreferences>().getString('clintId')) {
                      scaffoldKey.currentState!.showBottomSheet(
                        backgroundColor: Colors.white.withOpacity(0),
                        elevation: 0,
                        (context) {
                          return Material(
                            elevation: 12,
                            color: BreedsTypeCubit.get(context).isDark!
                                ? Colors.grey.shade800
                                : Colors.grey.shade200,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.minimize),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      print('$imageUrl${data.image}');
                                      print(data.id);
                                      print(data.userId);
                                      print(sl<SharedPreferences>()
                                          .getString('clintId'));
                                      print(data.postId);
                                      print(data.pet);
                                      print(data.content);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditComment(
                                              text: data.content,
                                              image: data.pet == null
                                                  ? "$imageUrl${data.user!.imageName}"
                                                  : "$imageUrl${data.pet!.imageName}",
                                              commentImage: '${data.image}',
                                              petId: data.petId,
                                              postId: data.postId,
                                              id: data.id,
                                            ),
                                          ));
                                    },
                                    child:  Row(
                                      children: [
                                        Text(S.of(context).editComment.substring(0,13)),
                                        Spacer(),
                                        Icon(Icons.edit),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      print(data.id);
                                      CommentCubit.get(context)
                                          .deleteComment(commentId: data.id);
                                      Navigator.of(scaffoldKey.currentContext!)
                                          .pop();
                                    },
                                    child:  Row(
                                      children: [
                                        Text(S.of(context).deleteComment),
                                        Spacer(),
                                        Icon(Icons.close),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: BreedsTypeCubit.get(context).isDark!
                          ? Colors.white10
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width/1.2,
                          child: Text(
                            '${data.pet == null ? data.user!.fullName : data.pet!.petName}',
                            style:
                            Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          data.content,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentReply(
                            postId: data.postId,
                            comments: data,
                          ),
                        ));
                  },
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.grey[700], fontWeight: FontWeight.bold),
                    child:  Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text(S.of(context).reply),
                        ],
                      ),
                    ),
                  ),
                ),
                if (data.image != '')
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      height: 150,
                      imageUrl: '$imageUrl${data.image}',
                    ),
                  ),
              ],
            );
          },
          contentRoot: (context, data) {
            return const Column();
          },
        ),
      ),
    );
  }
}
