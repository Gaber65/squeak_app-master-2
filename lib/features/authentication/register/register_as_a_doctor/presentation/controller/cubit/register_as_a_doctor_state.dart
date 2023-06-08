
import '../../../domain/entities/register_as_a_doctor.dart';

abstract class RegisterAsADoctorState{}

class RegisterInitialAsADoctorState extends RegisterAsADoctorState{}

class ChangeRegisterAsADoctorPasswordVisibility extends RegisterAsADoctorState{}
class ChangeRegisterAsADoctorConPasswordVisibility extends RegisterAsADoctorState{}

class GetRegisterAsADoctorLoadingState extends RegisterAsADoctorState{}
class GetRegisterAsADoctorSuccessState extends RegisterAsADoctorState{
  final  RegisterAsADoctor registerAsADoctor;

  GetRegisterAsADoctorSuccessState(this.registerAsADoctor);
}
class GetRegisterAsADoctorErrorState extends RegisterAsADoctorState{
  final String error;
  GetRegisterAsADoctorErrorState(this.error);
}