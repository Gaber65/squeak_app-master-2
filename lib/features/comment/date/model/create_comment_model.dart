import 'package:equatable/equatable.dart';

import '../../domain/entities/create_comment_entites.dart';
import 'get_comment_model.dart';

class CreateCommentModel extends CreateCommentEntities {
  const CreateCommentModel({
    required super.commentDate,
  });

  factory CreateCommentModel.fromJson(Map<String, dynamic> json) {
    return CreateCommentModel(
      commentDate: CommentDateModel.fromJson(json['data']),
    );
  }
}

class CommentDateModel extends CommentDate {
  const CommentDateModel({
    required super.id,
    required super.content,
    required super.image,
    required super.petId,
    required super.userId,
    required super.postId,
    required super.post,
    required super.pet,
  });

  factory CommentDateModel.fromJson(Map<String, dynamic> json) {
    return CommentDateModel(
      id: json['id'],
      content: json['content'],
      image: json['image'],
      petId: json['petId'],
      userId: json['userId'],
      postId: json['postId'],
      post: json['post'] == null ? null : PostDataModel.fromJson(json['post']),
      pet: json['pet'] == null ? null : PetDateModel.fromJson(json['pet']),
    );
  }
}

class PostDataModel extends PostData {
  const PostDataModel({
    required super.title,
    required super.content,
    required super.image,
    required super.video,
  });
  factory PostDataModel.fromJson(Map<String, dynamic> json) {
    return PostDataModel(
      title: json['title'],
      content: json['content'],
      image: json['image'],
      video: json['video'],
    );
  }
}

class PetDateModel extends PetDate {
  const PetDateModel({
    required super.petName,
    required super.gender,
    required super.breedId,
    required super.imageName,
  });
  factory PetDateModel.fromJson(Map<String, dynamic> json) {
    return PetDateModel(
      petName: json['petName'],
      gender: json['gender'],
      breedId: json['breedId'],
      imageName: json['imageName'],
    );
  }
}

