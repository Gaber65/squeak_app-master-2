import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../entities/create_comment_entites.dart';
import '../entities/get_comment_post.dart';
import '../repository/base_comment_repository.dart';


class GetCommentRepliesPostUseCase extends BaseUseCase<GetCommentEntities, GetRepliesCommentParameters> {
  final BaseCommentRepository baseCommentRepository;

  GetCommentRepliesPostUseCase(this.baseCommentRepository);

  @override
  Future<Either<Failure, GetCommentEntities>> call(GetRepliesCommentParameters parameters)async {
    return await baseCommentRepository.getCommentReplies(parameters);
  }
}

