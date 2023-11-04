import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/features/comment/domain/entities/get_comment_post.dart';
import 'package:squeak/features/comment/presentation/components/success_comment.dart';
import 'package:squeak/features/comment/presentation/controller/comment_cubit.dart';

import '../../../../core/network/end-points.dart';
import '../../../../core/network/helper/helper_cubit.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../../../layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import '../../../setting/update_profile/domain/entities/find_pet_by_owner_id_data.dart';
import '../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../components/loading_comment.dart';
import '../components/success_reply_comment.dart';

class CommentReply extends StatefulWidget {
  CommentReply({Key? key, required this.postId, required this.comments})
      : super(key: key);
  String postId;
  Comments comments;
  @override
  State<CommentReply> createState() => _CommentReplyState();
}

class _CommentReplyState extends State<CommentReply> {
  var commentController = TextEditingController();
  String? dropDown;
  String? dropDownId;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CommentCubit>()
            ..getComment(postId: widget.postId)
            ..getCommentReplies(
                postId: widget.postId, parentId: widget.comments.id),
        ),
        BlocProvider(
          create: (context) => sl<HelperCubit>(),
        ),
      ],
      child: BlocConsumer<CommentCubit, CommentState>(
        listener: (context, state) {
          if (state is CommentImagePickedSuccessState) {
            HelperCubit.get(context).getGlobalImage(
                file: state.file, uploadPlace: UploadPlace().commentImages);
          }
          if (state is DeleteCommentSuccess) {
            CommentCubit.get(context).replies = [];
            CommentCubit.get(context).getCommentReplies(
                postId: widget.postId, parentId: widget.comments.id);
          }
          if (state is CreateCommentSuccess) {
            CommentCubit.get(context).replies = [];
            CommentCubit.get(context).getCommentReplies(
                postId: widget.postId, parentId: widget.comments.id);
          }
          if (state is UpdateCommentSuccess) {
            CommentCubit.get(context).getCommentReplies(
                postId: widget.postId, parentId: widget.comments.id);
          }
        },
        builder: (context, state) {
          var cubit = CommentCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: buildAppBar(context),
            body: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                return cubit.getCommentReplies(
                  postId: widget.postId,
                  parentId: widget.comments.id,
                );
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      if (cubit.replies.isNotEmpty)
                        Expanded(
                          child: SuccessReplayComment(
                            scaffoldKey: scaffoldKey,
                            commentController: commentController,
                            replies: cubit.replies,
                            parentComments: widget.comments,
                          ),
                        ),
                      if (state is GetCommentRepliesLoading)
                        Expanded(
                          child: CommentWidget(
                            scaffoldKey: scaffoldKey,
                          ),
                        )
                    ],
                  ),
                  if (state is GetCommentRepliesSuccess)
                    const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: BreedsTypeCubit.get(context).isDark!
                              ? Colors.black
                              : Colors.white,
                          border: Border.all(
                            width: .2,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (cubit.commentImage != null)
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5.0,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          4.0,
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(cubit.commentImage!),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const CircleAvatar(
                                        radius: 20.0,
                                        child: Icon(
                                          Icons.close,
                                          size: 16.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        cubit.removePostImage();
                                        HelperCubit.get(context).modelImage =
                                            null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (cubit.commentImage != null)
                              const SizedBox(
                                height: 12,
                              ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cubit.getPostCamera();
                                  },
                                  icon: const Icon(IconlyLight.image),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: commentController,
                                    decoration: InputDecoration(
                                      focusColor: Colors.red,
                                      label: Text(S.of(context).addComment),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          print(widget.comments.id);
                                          cubit
                                              .createComment(
                                            postId: widget.postId,
                                            content: commentController.text,
                                            petId: dropDownId,
                                            image: HelperCubit.get(context)
                                                        .modelImage ==
                                                    null
                                                ? ''
                                                : HelperCubit.get(context)
                                                    .modelImage!
                                                    .data!,
                                            parentId: widget.comments.id,
                                          )
                                              .then((value) {
                                            HelperCubit.get(context)
                                                .modelImage = null;
                                            cubit.commentImage = null;
                                            commentController.clear();
                                          });
                                        },
                                        icon: const Icon(IconlyLight.send),
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.of(context).commentReply),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<PetsData>(
            onChanged: (newValue) {
              setState(() {
                dropDown = '$imageUrl${newValue!.imageName}';
                dropDownId = newValue.petId;
                print(dropDownId);
                print(dropDown);
              });
            },
            isExpanded: false,
            iconSize: 0.0,
            elevation: 0,
            icon: const SizedBox.shrink(),
            underline: const SizedBox(),
            hint: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
              dropDown ??
                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
            )),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            items: SqueakCubit.get(context)
                .ownerPetsEntities!
                .data!
                .map((PetsData value) {
              return DropdownMenuItem<PetsData>(
                value: value,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      CachedNetworkImageProvider('$imageUrl${value.imageName}'),
                ),
              );
            }).toList(),
          ),
          // CommentPetDropDown(
          //   petsData:
          //       SqueakCubit.get(context).ownerPetsEntities.data!,
          //
          // ),
        ),
      ],
    );
  }
}
