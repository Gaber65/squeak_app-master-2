import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/features/comment/domain/repository/base_comment_repository.dart';
import 'package:squeak/features/comment/domain/usecase/get_comment_replies_use_case.dart';

import '../../../../core/service/service_locator.dart';
import '../../domain/entities/create_comment_entites.dart';
import '../../domain/entities/get_comment_post.dart';
import '../../domain/usecase/create_comment_use_case.dart';
import '../../domain/usecase/delete_comment_use_case.dart';
import '../../domain/usecase/get_comment_use_case.dart';
import '../../domain/usecase/update_comment_use_case.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit(
    this.deleteCommentPostUseCase,
    this.updateCommentUseCase,
    this.getCommentPostUseCase,
    this.createCommentUseCase,
    this.getCommentRepliesPostUseCase,
  ) : super(CommentInitial());

  static CommentCubit get(context) => BlocProvider.of(context);

  File? commentImage;
  var picker = ImagePicker();
  Future<void> getPostCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      commentImage = File(pickedFile.path);
      emit(CommentImagePickedSuccessState(commentImage!));
    } else {
      debugPrint('No image selected.');
      emit(CommentImagePickedErrorState());
    }
  }

  void removePostImage() async {
    commentImage = null;
    emit(CommentRemovePostImageState());
  }

  CreateCommentUseCase createCommentUseCase;
  Future<void> createComment({
    required String postId,
    required String content,
    required String? petId,
    required String? image,
    required String? parentId,
  }) async {
    emit(CreateCommentLoading());
    final result = await createCommentUseCase(CreateCommentParameters(
      content: content,
      image: image ?? null,
      user: sl<SharedPreferences>().getString('clintId')!,
      petId: petId ?? null,
      postId: postId,
      parentId: parentId,
    ));
    result.fold((l)=> emit(CreateCommentError()) , (r) => emit(CreateCommentSuccess()) );
  }

  UpdateCommentUseCase updateCommentUseCase;
  Future<void> updateComment({
    required String commentId,
    required String postId,
    required String content,
    required String? petId,
    required String? image,
    required String? parentId,
  }) async {
    emit(UpdateCommentLoading());
    final result = await updateCommentUseCase(CreateCommentParameters(
      content: content,
      image: image ?? null,
      user: sl<SharedPreferences>().getString('clintId')!,
      petId: petId ?? null,
      postId: postId,
      commentId: commentId,
      parentId: parentId,
    ));
    result.fold((l)=> emit(UpdateCommentError()) , (r) => emit(UpdateCommentSuccess()) );
  }

  DeleteCommentPostUseCase deleteCommentPostUseCase;
  Future<void> deleteComment({
    required String commentId,
  }) async {
    emit(DeleteCommentLoading());
    final result =
        await deleteCommentPostUseCase(GetCommentParameters(postId: commentId));
    result.fold(
      (l) => emit(DeleteCommentError()),
      (r) => emit(DeleteCommentSuccess()),
    );
  }

  GetCommentPostUseCase getCommentPostUseCase;
  GetCommentEntities? commentEntities;
  Future<void> getComment({
    required String postId,
  }) async {
    emit(GetCommentLoading());
    final result = await getCommentPostUseCase(
      GetCommentParameters(
        postId: postId,
      ),
    );
    result.fold(
      (l) => emit(GetCommentError()),
      (r) {
        commentEntities =r;
        print(r);
        emit(GetCommentSuccess(r));
      }
    );
  }
  GetCommentRepliesPostUseCase getCommentRepliesPostUseCase;
  List<Comments> replies =[];
  Future<void> getCommentReplies({
    required String postId,
    required String parentId,
  }) async {
    emit(GetCommentRepliesLoading());
    final result = await getCommentRepliesPostUseCase(
      GetRepliesCommentParameters(
        postId: postId,
        parentId: parentId
      ),
    );
    result.fold(
            (l) => emit(GetCommentRepliesError()),
            (r) {
              replies = r.commentDate.comments;
              debugPrint('*********************${replies}**********************');
          print(r);
          emit(GetCommentRepliesSuccess(r.commentDate.comments));
        }
    );
  }
}
