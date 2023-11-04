import 'package:equatable/equatable.dart';
import 'package:squeak/features/comment/domain/entities/create_comment_entites.dart';

class GetCommentEntities extends Equatable {
  final GetCommentDate commentDate;

  const GetCommentEntities({
    required this.commentDate,
  });

  @override
  List<Object> get props => [
        commentDate,
      ];
}

class GetCommentDate extends Equatable {
  final int count;
  final List<Comments> comments;

  const GetCommentDate({
    required this.count,
    required this.comments,
  });

  @override
  List<Object> get props => [
        count,
        comments,
      ];
}

class Comments extends Equatable {
  const Comments({
    required this.id,
    required this.content,
    required this.image,
    this.petId,
    required this.userId,
    required this.postId,
    required this.post,
    this.pet,
    required this.user,
  });

  final String id;
  final String content;
  final dynamic image;
  final dynamic? petId;
  final String userId;
  final String postId;
  final PostData? post;
  final PetDate? pet;
  final UserData? user;

  @override
  List<Object?> get props => [
        id,
        content,
        image,
        petId,
        userId,
        postId,
        post,
        pet,
        user,
      ];
}

class UserData extends Equatable {
  const UserData({
    required this.fullName,
    required this.address,
    required this.imageName,
    required this.birthDate,
  });

  final dynamic fullName;
  final dynamic address;
  final dynamic imageName;
  final dynamic birthDate;

  @override
  List<Object?> get props => [
        fullName,
        address,
        imageName,
        birthDate,
      ];
}
