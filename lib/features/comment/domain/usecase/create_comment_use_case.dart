import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../entities/create_comment_entites.dart';
import '../repository/base_comment_repository.dart';


class CreateCommentUseCase extends BaseUseCase<CreateCommentEntities, CreateCommentParameters> {
  final BaseCommentRepository baseCommentRepository;

  CreateCommentUseCase(this.baseCommentRepository);

  @override
  Future<Either<Failure, CreateCommentEntities>> call(CreateCommentParameters parameters)async {
    return await baseCommentRepository.createComment(parameters);
  }
}

