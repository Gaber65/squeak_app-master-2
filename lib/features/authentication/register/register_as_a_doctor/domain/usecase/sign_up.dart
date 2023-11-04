import '../../../../../../core/usecase/base_usecase.dart';
import '../repository/base_register_as_a_doctor.dart';

class SignUpUseCase extends BaseUseCase2<void , SignInParameters>
{
  final BaseRegisterAsADoctorRepository authBaseRepository;

  SignUpUseCase(this.authBaseRepository);

  @override
  Future call(SignInParameters parameters)  async
  {
    return await authBaseRepository.signUp(parameters);
  }



}

