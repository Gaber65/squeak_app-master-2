import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../entities/reset_password.dart';
import '../repository/base_auth_repository.dart';


class GetResetPasswordUseCase
    extends BaseUseCase<ResetPassword, ResetPasswordParameters> {
  final BaseLoginRepository baseLoginRepository;

  GetResetPasswordUseCase(this.baseLoginRepository);
  @override
  Future<Either<Failure, ResetPassword>> call(
      ResetPasswordParameters parameters) async {
    return await baseLoginRepository.getResetPassword(parameters);
  }
}
