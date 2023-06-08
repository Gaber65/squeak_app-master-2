import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';


import '../entities/verfication_code.dart';
import '../repository/base_verification_code_repository.dart';



class GetVerificationCodeUseCase extends BaseUseCase<VerificationCode,VerificationParameters>
{
  final BaseVerificationCodeRepository baseVerificationCodeRepository;

  GetVerificationCodeUseCase(this.baseVerificationCodeRepository);
  @override
  Future<Either<Failure, VerificationCode>> call(VerificationParameters parameters)async {
    return await baseVerificationCodeRepository.getVerificationCode(parameters);
  }

}