import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../entities/forget_password.dart';
import '../repository/base_auth_repository.dart';

class GetForgetPasswordUserCase
    extends BaseUseCase<ForgetPassword, ForgetPasswordParameters> {
  final BaseLoginRepository baseLoginRepository;

  GetForgetPasswordUserCase(this.baseLoginRepository);
  @override
  Future<Either<Failure, ForgetPassword>> call(
      ForgetPasswordParameters parameters) async {
    return await baseLoginRepository.getForgetPassword(parameters);
  }
}
