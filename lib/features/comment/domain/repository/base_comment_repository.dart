import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/comment/domain/entities/create_comment_entites.dart';

import '../entities/delete_comment_entites.dart';
import '../entities/get_comment_post.dart';

abstract class BaseCommentRepository {
  Future<Either<Failure, CreateCommentEntities>> createComment(CreateCommentParameters parameters);
  Future<Either<Failure, CreateCommentEntities>> updateComment(CreateCommentParameters parameters);
  Future<Either<Failure, GetCommentEntities>> getComment(GetCommentParameters parameters);
  Future<Either<Failure, GetCommentEntities>> getCommentReplies(GetRepliesCommentParameters parameters);
  Future<Either<Failure, DeleteCommentEntities>> deleteComment(GetCommentParameters parameters);
}

class CreateCommentParameters extends Equatable {
  final String content;
  final String? image;
  final String user;
  final String? petId;
  final String postId;
  final String? commentId;
  final String? parentId;
  const CreateCommentParameters({
    required this.content,
    required this.image,
    required this.user,
    required this.petId,
    required this.postId,
    required this.parentId,
    this.commentId,
  });

  @override
  List<Object> get props => [content, user, postId];
}

class GetCommentParameters extends Equatable {
  final String postId;

  const GetCommentParameters({
    required this.postId,
  });

  @override
  List<Object> get props => [postId];
}

class GetRepliesCommentParameters extends Equatable {
  final String postId;
  final String parentId;

  const GetRepliesCommentParameters({
    required this.postId,
    required this.parentId,
  });

  @override
  List<Object> get props => [
        postId,
        parentId,
      ];
}
