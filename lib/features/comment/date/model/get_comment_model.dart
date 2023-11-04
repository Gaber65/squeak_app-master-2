import 'package:squeak/features/comment/date/model/create_comment_model.dart';

import '../../domain/entities/create_comment_entites.dart';
import '../../domain/entities/get_comment_post.dart';

class GetCommentModel extends GetCommentEntities {
  const GetCommentModel({required super.commentDate});
  factory GetCommentModel.fromJson(Map<String, dynamic> json) {
    return GetCommentModel(
      commentDate: GetCommentDateModel.fromJson(json['data']),
    );
  }
}

class GetCommentDateModel extends GetCommentDate {
  const GetCommentDateModel({required super.count, required super.comments});

  factory GetCommentDateModel.fromJson(Map<String, dynamic> json) {
    return GetCommentDateModel(
      count: json['count'],
      comments: List.from(json['comments'])
          .map((e) => CommentsModel.fromJson(e))
          .toList(),
    );
  }
}

class CommentsModel extends Comments {
  const CommentsModel({
    required super.id,
    required super.content,
    required super.image,
    required super.userId,
    required super.postId,
    required super.post,
    required super.user,
    required super.petId,
    required super.pet,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return CommentsModel(
      id: json['id'],
      content: json['content'],
      image: json['image'],
      userId: json['userId'],
      petId: json['petId'],
      pet: json['pet'] == null ? null : PetDateModel.fromJson(json['pet']),
      postId: json['postId'],
      post: json['post'] == null ? null : PostDataModel.fromJson(json['post']),
      user: UserDataModel.fromJson(json['user']),
    );
  }
}

class UserDataModel extends UserData {
  const UserDataModel({
    required super.fullName,
    required super.address,
    required super.imageName,
    required super.birthDate,
  });
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      fullName: json['fullName'],
      address: json['address'],
      imageName: json['imageName'],
      birthDate: json['birthDate'],
    );
  }
}


