import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/dio.dart';
import '../../../../core/network/end-points.dart';
import '../../../../core/service/service_locator.dart';
import '../../domain/repository/base_comment_repository.dart';
import '../model/create_comment_model.dart';
import '../model/delete_comment_model.dart';
import '../model/get_comment_model.dart';

abstract class BaseCommentRemoteDataSource {

  Future<CreateCommentModel> createCommentDataSource(CreateCommentParameters parameters);
  Future<CreateCommentModel> updateCommentDataSource(CreateCommentParameters parameters);
  Future<GetCommentModel> getCommentDataSource(GetCommentParameters parameters);
  Future<GetCommentModel> getCommentRepliesDataSource(GetRepliesCommentParameters parameters);
  Future<DeleteCommentModel> deleteCommentDataSource(GetCommentParameters parameters);
}

class CommentRemoteDataSource extends BaseCommentRemoteDataSource {
  @override
  Future<CreateCommentModel> createCommentDataSource(
      CreateCommentParameters parameters) async {
    var result = await DioFinalHelper.postData(
        method: '$version$createCommentEndPoint',
        token: sl<SharedPreferences>().getString('refreshToken'),
        data: {
          "content": parameters.content,
          "image": parameters.image,
          "petId": parameters.petId,
          "postId": parameters.postId,
          "parentId": parameters.parentId
        });

    return CreateCommentModel.fromJson(result.data!);
  }

  @override
  Future<DeleteCommentModel> deleteCommentDataSource(
      GetCommentParameters parameters) async {
    var result = await DioFinalHelper.deleteData(
      method: '$version$deleteCommentEndPoint/${parameters.postId}',
      token: sl<SharedPreferences>().getString('refreshToken'),
    );
    return DeleteCommentModel.fromJson(result.data!);
  }


  @override
  Future<CreateCommentModel> updateCommentDataSource(
      CreateCommentParameters parameters) async {
    var result = await DioFinalHelper.patchData(
      method: '$version$updateCommentEndPoint${parameters.commentId}',
      token: sl<SharedPreferences>().getString('refreshToken'),
      data: {
        "content": parameters.content,
        "image": parameters.image,
        "petId": parameters.petId,
        "postId": parameters.postId
      },
    );
    return CreateCommentModel.fromJson(result.data!);
  }

  @override
  Future<GetCommentModel> getCommentRepliesDataSource(
      GetRepliesCommentParameters parameters) async {
    var result = await DioFinalHelper.getData(
      method: '$version$getCommentEndPoint',
      token: sl<SharedPreferences>().getString('refreshToken'),
      query: {
        "ParentId" : parameters.parentId,
        "PostId" : parameters.postId
      },
    );
    print('************************${result.data['data']['comments']}*******************');
    return GetCommentModel.fromJson(result.data!);
  }

  @override
  Future<GetCommentModel> getCommentDataSource(
      GetCommentParameters parameters) async {
    var result = await DioFinalHelper.getData(
      method: '$version$getCommentEndPoint',
      token: sl<SharedPreferences>().getString('refreshToken'),
      query: {
        "PostId" : parameters.postId,
        "ParentId" : '',

      },
    );
    return GetCommentModel.fromJson(result.data!);
  }

}
