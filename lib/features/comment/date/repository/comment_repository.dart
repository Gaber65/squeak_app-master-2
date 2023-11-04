import 'package:dartz/dartz.dart';

import 'package:squeak/core/error/failure.dart';

import 'package:squeak/features/comment/domain/entities/create_comment_entites.dart';

import 'package:squeak/features/comment/domain/entities/delete_comment_entites.dart';

import 'package:squeak/features/comment/domain/entities/get_comment_post.dart';

import '../../../../core/error/exception.dart';
import '../../domain/repository/base_comment_repository.dart';
import '../data_source/base_comment_data_source.dart';

class CommentRepository extends BaseCommentRepository {
  final BaseCommentRemoteDataSource baseCommentRemoteDataSource;

  CommentRepository(this.baseCommentRemoteDataSource);

  @override
  Future<Either<Failure, CreateCommentEntities>> createComment(
      CreateCommentParameters parameters) async {
    final result =
        await baseCommentRemoteDataSource.createCommentDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, DeleteCommentEntities>> deleteComment(
      GetCommentParameters parameters) async {
    final result =
    await baseCommentRemoteDataSource.deleteCommentDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, GetCommentEntities>> getComment(
      GetCommentParameters parameters) async {
    final result =
    await baseCommentRemoteDataSource.getCommentDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, CreateCommentEntities>> updateComment(
      CreateCommentParameters parameters) async {
    final result =
    await baseCommentRemoteDataSource.updateCommentDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, GetCommentEntities>> getCommentReplies(GetRepliesCommentParameters parameters) async{
    final result =
    await baseCommentRemoteDataSource.getCommentRepliesDataSource(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.statusErrorMessageModel.message));
    }
  }
}
