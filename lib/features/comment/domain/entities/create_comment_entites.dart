import 'package:equatable/equatable.dart';

class CreateCommentEntities extends Equatable {
  final CommentDate commentDate;

  const CreateCommentEntities({
    required this.commentDate,
  });

  @override
  List<Object> get props => [
        commentDate,
      ];
}

class CommentDate extends Equatable {
  const CommentDate({
    required this.id,
    required this.content,
    required this.image,
    required this.petId,
    required this.userId,
    required this.postId,
    required this.post,
    required this.pet,
    this.user,
  });

  final String id;
  final String content;
  final String image;
  final dynamic petId;
  final String userId;
  final String postId;
  final dynamic user;
  final dynamic post;
  final PetDate? pet;

  @override
  List<Object> get props => [
        id,
        content,
        image,
        petId,
        userId,
        postId,
        post,
      ];
}

class PostData extends Equatable {
  const PostData({
    required this.title,
    required this.content,
    required this.image,
    required this.video,
  });

  final String title;
  final String content;
  final dynamic image;
  final dynamic video;

  @override
  List<Object?> get props => [
        title,
        content,
        image,
        video,
      ];
}

class PetDate extends Equatable {
  const PetDate({
    required this.petName,
    required this.gender,
    required this.breedId,
    required this.imageName,
  });

  final dynamic petName;
  final dynamic gender;
  final dynamic breedId;
  final dynamic imageName;

  @override
  List<Object> get props => [
        petName,
        gender,
        breedId,
        imageName,
      ];
}


