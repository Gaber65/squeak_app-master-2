import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/entities/register.dart';
import 'package:squeak/features/authentication/register/register_as_a_user/domain/repository/base_register_repository.dart';

class GetRegisterUserUseCase extends BaseUseCase<Register, RegisterParameters> {
  final BaseRegisterRepository baseRegisterRepository;

  GetRegisterUserUseCase(this.baseRegisterRepository);
  @override
  Future<Either<Failure, Register>> call(RegisterParameters parameters) async {
    return await baseRegisterRepository.getUserRegister(parameters);
  }
}
