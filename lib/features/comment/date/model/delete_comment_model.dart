
import '../../domain/entities/delete_comment_entites.dart';

class DeleteCommentModel extends DeleteCommentEntities{
  const DeleteCommentModel({required super.data});

  factory DeleteCommentModel.fromJson(Map<String, dynamic> json) {
    return DeleteCommentModel(
      data: DeleteDataModel.fromJson(json['data']),
    );
  }
}
class DeleteDataModel extends DeleteData{
  const DeleteDataModel.fromJson(Map json);
}