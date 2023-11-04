import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/network/end-points.dart';

import '../../../../core/network/helper/helper_cubit.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../controller/comment_cubit.dart';
import '../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';

class EditComment extends StatefulWidget {
  EditComment({
    Key? key,
    required this.text,
    required this.image,
    required this.commentImage,
    required this.petId,
    required this.postId,
    required this.id,
  }) : super(key: key);
  String image;
  String text;
  String commentImage;
  String id;
  String postId;
  dynamic petId;
  @override
  State<EditComment> createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {
  String url = 'http://squeak101-001-site1.itempurl.com/files/';
  var commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    commentController.text = widget.text;
    print(commentController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CommentCubit>(),
      child: BlocConsumer<CommentCubit, CommentState>(
        listener: (context, state) {
          if (state is CommentImagePickedSuccessState) {
            HelperCubit.get(context).getGlobalImage(
                file: state.file, uploadPlace: UploadPlace().commentImages);
            CommentCubit.get(context).getComment(postId: widget.postId);
            CommentCubit.get(context)
                .getCommentReplies(postId: widget.postId, parentId: widget.id);
          }
          if (state is UpdateCommentSuccess) {
            CommentCubit.get(context).getComment(postId: widget.postId);
            CommentCubit.get(context)
                .getCommentReplies(postId: widget.postId, parentId: widget.id);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).editComment.substring(0, 13)),
              actions: [
                MaterialButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      CommentCubit.get(context)
                          .updateComment(
                        postId: widget.postId,
                        commentId: widget.id,
                        content: commentController.text,
                        petId: widget.petId,
                        parentId: null,
                        image: HelperCubit.get(context).modelImage == null
                            ? widget.commentImage
                            : HelperCubit.get(context).modelImage!.data,
                      )
                          .then((value) {
                        CommentCubit.get(context)
                            .getComment(postId: widget.postId);
                      });
                    }
                  },
                  child: const Icon(IconlyLight.paper_upload)
                ),
              ],
            ),
            body: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state is UpdateCommentLoading) const LinearProgressIndicator(),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(widget.image),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        CommentCubit.get(context)
                                            .getPostCamera();
                                      },
                                      icon: const Icon(IconlyLight.image),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return '';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: commentController,
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
                  if (widget.commentImage.isNotEmpty ||
                      CommentCubit.get(context).commentImage != null)
                    Stack(
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
                              image:
                                  CommentCubit.get(context).commentImage == null
                                      ? CachedNetworkImageProvider(
                                          '$imageUrl${widget.commentImage}')
                                      : FileImage(CommentCubit.get(context)
                                          .commentImage!) as ImageProvider,
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
                            CommentCubit.get(context).removePostImage();
                            HelperCubit.get(context).modelImage = null;
                            setState(() {
                              widget.commentImage = '';
                              print(widget.commentImage);
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
