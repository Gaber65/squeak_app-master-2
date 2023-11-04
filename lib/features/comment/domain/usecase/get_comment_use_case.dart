import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../entities/get_comment_post.dart';
import '../repository/base_comment_repository.dart';


class GetCommentPostUseCase extends BaseUseCase<GetCommentEntities, GetCommentParameters> {
  final BaseCommentRepository baseCommentRepository;

  GetCommentPostUseCase(this.baseCommentRepository);

  @override
  Future<Either<Failure, GetCommentEntities>> call(GetCommentParameters parameters)async {
    return await baseCommentRepository.getComment(parameters);
  }
}

