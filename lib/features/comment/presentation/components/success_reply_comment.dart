import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/features/comment/domain/entities/create_comment_entites.dart';
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

class SuccessReplayComment extends StatelessWidget {
  SuccessReplayComment({
    super.key,
    required this.scaffoldKey,
    required this.replies,
    required this.commentController,
    required this.parentComments,
  });
  final GlobalKey<ScaffoldState> scaffoldKey;
  List<Comments> replies;
  TextEditingController commentController;

  Comments parentComments;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: CommentTreeWidget<Comments, Comments>(
          Comments(
            id: parentComments.id,
            content: parentComments.content,
            image: parentComments.image,
            userId: parentComments.userId,
            postId: parentComments.postId,
            user: parentComments.user,
            post: null,
            petId: parentComments.petId,
            pet: parentComments.pet,
          ),
          replies,
          treeThemeData: TreeThemeData(
            lineColor: appColorBtn!,
            lineWidth: 1,
          ),
          avatarRoot: (context, data) => PreferredSize(
            preferredSize: const Size.fromRadius(18),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(
                parentComments.pet == null
                    ? "$imageUrl${parentComments.user!.imageName}"
                    : "$imageUrl${parentComments.pet!.imageName}",
              ),
            ),
          ),
          avatarChild: (context, data) =>  PreferredSize(
            preferredSize: const Size.fromRadius(12),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey,
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
                  onLongPress: (){
                    print(sl<SharedPreferences>().getString('clintId'));
                    print(data.userId);
                    if (data.userId == sl<SharedPreferences>().getString('clintId')) {
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
                                      print(parentComments.id);
                                      print(parentComments.userId);
                                      print(sl<SharedPreferences>()
                                          .getString('clintId'));
                                      print(parentComments.postId);
                                      print(parentComments.pet);
                                      print(parentComments.content);
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
                                        const Spacer(),
                                        const Icon(Icons.edit),
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
                                        const Spacer(),
                                        const Icon(Icons.close)
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
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${data.pet == null ? data.user!.fullName : data.pet!.petName}',
                              style:
                              Theme.of(context).textTheme.caption?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            if (data.pet != null)
                              Text(
                                'Owner \'${data.user!.fullName} ',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12),
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
                        if (data.image != '')
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              height: 150,
                              imageUrl: '$imageUrl${data.image}',
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          contentRoot: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Row(
                        children: [
                          Text(
                            '${data.pet == null ? data.user!.fullName : data.pet!.petName}',
                            style:
                            Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          if (data.pet != null)
                            Text(
                              'Owner \'${data.user!.fullName} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12),
                            ),
                        ],
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
        ),
      ),
    );
  }
}
