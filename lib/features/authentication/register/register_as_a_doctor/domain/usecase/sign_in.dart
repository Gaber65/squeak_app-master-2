import '../../../../../../core/usecase/base_usecase.dart';
import '../repository/base_register_as_a_doctor.dart';

class SignInUseCase extends BaseUseCase2<dynamic , SignInParameters>
{
  final BaseRegisterAsADoctorRepository authBaseRepository;

  SignInUseCase(this.authBaseRepository);

  @override
  Future call(SignInParameters parameters)  async
  {
    return await authBaseRepository.signIn(parameters);
  }

}
