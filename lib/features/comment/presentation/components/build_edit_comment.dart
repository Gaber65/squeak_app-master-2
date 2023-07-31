import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/helper/helper_cubit.dart';
import '../../../../core/service/service_locator.dart';
import '../../../comment/presentation/controller/comment_cubit.dart';
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
  String petId;
  @override
  State<EditComment> createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {
  String url = 'http://squeak101-001-site1.itempurl.com/files/';
  var commentController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CommentCubit>(),
      child: BlocConsumer<CommentCubit, CommentState>(
        listener: (context, state) {
          if (state is CommentImagePickedSuccessState) {
            HelperCubit.get(context).getGlobalImage(
                file: state.file, uploadPlace: UploadPlace().commentImages);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Edit"),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(widget.image),
                    ),
                    Expanded(
                      child: Padding(
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
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        CommentCubit.get(context)
                                            .getPostCamera();
                                      },
                                      icon: const Icon(Icons.image),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: commentController,
                                        decoration: const InputDecoration(
                                          focusColor: Colors.red,
                                          label: Text(
                                            'Add Your Comment . . . ',
                                            style: TextStyle(
                                              fontFamily: 'bold',
                                              color: Colors.grey,
                                            ),
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
                    ),
                  ],
                ),
                if (widget.commentImage != url ||
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
                            image: CommentCubit.get(context).commentImage ==
                                    null
                                ? CachedNetworkImageProvider(
                                    widget.commentImage)
                                : FileImage(
                                        CommentCubit.get(context).commentImage!)
                                    as ImageProvider,
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
                            widget.commentImage = url;
                            print(widget.commentImage);
                          });
                        },
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          CommentCubit.get(context).updateComment(
                            postId: widget.postId,
                            commentId: widget.id,
                            content: commentController.text,
                            petId: widget.petId,
                            image: HelperCubit.get(context).modelImage == null ? '' : HelperCubit.get(context).modelImage!.data!,
                          );
                        },
                        child: const Text(
                          'Update',
                        )),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
