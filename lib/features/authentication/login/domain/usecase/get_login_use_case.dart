import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';

import '../entities/login.dart';
import '../repository/base_auth_repository.dart';

class GetLoginUseCase extends BaseUseCase<Login,LoginParameters>
{
  final BaseLoginRepository baseLoginRepository;

  GetLoginUseCase(this.baseLoginRepository);
  @override
  Future<Either<Failure, Login>> call(LoginParameters parameters)async {
    return await baseLoginRepository.getUserLogin(parameters);
  }

}

