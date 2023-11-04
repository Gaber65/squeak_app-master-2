

import '../../../../core/usecase/base_usecase.dart';
import '../../../authentication/register/register_as_a_doctor/domain/entities/firebase_register_doctor.dart';
import '../base_repository/chat_base_repo.dart';

class GetUserDataUseCase extends BaseUseCase2<RegisterFireAsDoctor , NoParameters>
{
  final ChatBaseRepository profileBaseRepository;

  GetUserDataUseCase(this.profileBaseRepository);

  @override
  Future<RegisterFireAsDoctor> call(NoParameters parameters) async
  {
   return await profileBaseRepository.getUserData();
  }

}