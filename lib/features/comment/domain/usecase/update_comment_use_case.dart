import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../entities/create_comment_entites.dart';
import '../repository/base_comment_repository.dart';


class UpdateCommentUseCase extends BaseUseCase<CreateCommentEntities, CreateCommentParameters> {
  final BaseCommentRepository baseCommentRepository;

  UpdateCommentUseCase(this.baseCommentRepository);

  @override
  Future<Either<Failure, CreateCommentEntities>> call(CreateCommentParameters parameters)async {
    return await baseCommentRepository.updateComment(parameters);
  }
}

