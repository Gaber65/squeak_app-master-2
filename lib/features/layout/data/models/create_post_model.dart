import 'package:squeak/features/layout/domain/entites/post/create_post_entites.dart';

import '../../../authentication/login/data/model/login_model.dart';

class CreatePostModel extends PostEntities {
  CreatePostModel({
    required super.success,
    required super.errors,
    required super.data,
    required super.message,
    required super.statusCode,
  });
  CreatePostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errors = json['errors'] != null
        ? Map<String, List<dynamic>>.from(json['errors'])
        : json['errors'];
    data =json['data'] != null ? PostDataModel.fromJson(json['data']) :json['data'];
    message = json['message'];
    statusCode = json['statusCode'];
  }
}

class PostDataModel extends PostData {
  PostDataModel(
      {required super.count, required super.getPost, super.createPost});

  factory PostDataModel.fromJson(Map<String, dynamic> json) {
    return PostDataModel(
      count: json['count'],
      createPost:
          json['post'] != null ? PostsModel.fromJson(json['post']) : null,
      getPost: json['posts'] != null
          ? List.from(json['posts']).map((e) => PostsModel.fromJson(e)).toList()
          : null,
    );
  }
}

class PostsModel extends Posts {
  const PostsModel({
    required super.title,
    required super.content,
    required super.image,
    required super.video,
    required super.clinicPost,
    required super.speciePost,
    super.postId,
  });
  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      title: json['title'],
      content: json['content'],
      image: json['image'],
      video: json['video'],
      postId: json['id'],
      clinicPost: json['clinic'] == null
          ? json['clinic']
          : ClinicPostModel.fromJson(json['clinic']),
      speciePost: json['specie'] == null
          ? json['specie']
          : speciePostModel.fromJson(json['specie']),
    );
  }
}

class ClinicPostModel extends ClinicPost {
  const ClinicPostModel({
    required super.name,
    required super.location,
    required super.city,
    required super.address,
    required super.phone,
    required super.image,
    required super.code,
  });

  factory ClinicPostModel.fromJson(Map<String, dynamic> json) {
    return ClinicPostModel(
      name: json['name'],
      location: json['location'],
      city: json['city'],
      address: json['address'],
      phone: json['phone'],
      code: json['code'],
      image: json['image'],
    );
  }
}

class speciePostModel extends SpeciePost {
  const speciePostModel({
    required super.arType,
    required super.enType,
  });
  factory speciePostModel.fromJson(Map<String, dynamic> json) {
    return speciePostModel(
      arType: json['arType'],
      enType: json['enType'],
    );
  }
}
