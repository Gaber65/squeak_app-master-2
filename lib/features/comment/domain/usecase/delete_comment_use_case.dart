import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../entities/delete_comment_entites.dart';
import '../repository/base_comment_repository.dart';


class DeleteCommentPostUseCase extends BaseUseCase<DeleteCommentEntities, GetCommentParameters> {
  final BaseCommentRepository baseCommentRepository;

  DeleteCommentPostUseCase(this.baseCommentRepository);

  @override
  Future<Either<Failure, DeleteCommentEntities>> call(GetCommentParameters parameters)async {
    return await baseCommentRepository.deleteComment(parameters);
  }
}

