import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/dio_helper.dart';

import 'package:squeak/features/layout/cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/profile/data/datasource/base_profile_remote_data_source.dart';
import 'package:squeak/features/layout/profile/data/repository/profile_repository.dart';
import 'package:squeak/features/layout/profile/domain/repository/base_profile_repository.dart';
import 'package:squeak/features/layout/profile/domain/usecase/get_owner_pets.dart';
import 'package:squeak/features/layout/profile/domain/usecase/get_profile_user_use_case.dart';
import 'package:squeak/features/layout/update_profile/data/datasource/base_update_profile_data_source.dart';
import 'package:squeak/features/layout/update_profile/data/repository/update_profile_repository.dart';
import 'package:squeak/features/layout/update_profile/domain/repository/base_update_profile_repository.dart';
import 'package:squeak/features/layout/update_profile/domain/usecase/get_update_profile_use_case.dart';



import 'package:squeak/features/authentication/register/verficiation/data/datasource/base_verification_code_remote_use_case.dart';
import 'package:squeak/features/authentication/register/verficiation/data/repository/verification_code_repository.dart';
import 'package:squeak/features/authentication/register/verficiation/domain/repository/base_verification_code_repository.dart';
import 'package:squeak/features/authentication/register/verficiation/domain/usecase/get_verification_code_use_case.dart';
import 'package:squeak/features/authentication/register/verficiation/presentation/controller/cubit/ver_cubit.dart';

import '../../features/authentication/login/data/datasource/base_login_remote_data_source.dart';
import '../../features/authentication/login/data/repository/login_repository.dart';
import '../../features/authentication/login/domain/repository/base_auth_repository.dart';
import '../../features/authentication/login/domain/usecase/get_froget_password_use_case.dart';
import '../../features/authentication/login/domain/usecase/get_login_use_case.dart';
import '../../features/authentication/login/domain/usecase/get_reset_password_use_case.dart';
import '../../features/authentication/login/presentation/controller/cubit/login_cubit.dart';
import '../../features/authentication/register/register_as_a_doctor/data/datasource/base_register_as_a_doctor_remote_data_source.dart';
import '../../features/authentication/register/register_as_a_doctor/data/repository/register_as_a_doctor_repository.dart';
import '../../features/authentication/register/register_as_a_doctor/domain/repository/base_register_as_a_doctor.dart';
import '../../features/authentication/register/register_as_a_doctor/domain/usecase/get_register_as_a_doctor_use_case.dart';
import '../../features/authentication/register/register_as_a_doctor/presentation/controller/cubit/register_as_a_doctor_cubit.dart';
import '../../features/authentication/register/register_as_a_user/data/datasource/base_register_remote_data_source.dart';
import '../../features/authentication/register/register_as_a_user/data/repository/register_repository.dart';
import '../../features/authentication/register/register_as_a_user/domain/repository/base_register_repository.dart';
import '../../features/authentication/register/register_as_a_user/domain/usecase/get_register_user_use_case.dart';
import '../../features/authentication/register/register_as_a_user/presentation/controller/cubit/register_cubit.dart';
import '../../features/layout/profile/domain/usecase/get_breeds_use_case.dart';
import '../../features/layout/profile/domain/usecase/post_pets_use_case.dart';
import '../../features/layout/profile/domain/usecase/update_pits_use_case.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    sl.registerFactory(() => SqueakCubit(
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
        ));
    //////////////////////////////////////////////////////////////
    sl.registerLazySingleton(() => PostPetsUseCase(sl()));
    sl.registerLazySingleton(() => GetBreedsUseCase(sl()));
    sl.registerLazySingleton(() => GetOwnerPetsUseCase(sl()));
    sl.registerLazySingleton(() => UpdatePetsUseCase(sl()));

    //////////////////////////////////////////////////////////////
    sl.registerLazySingleton(() => GetProfileUseCase(sl()));

    sl.registerLazySingleton<BaseProfileRepository>(
        () => ProfileRepository(sl()));

    sl.registerLazySingleton<BaseProfileRemoteDataSource>(
        () => ProfileRemoteDataSource(sl()));

    /////////////////////////////////////////////////////////////

    sl.registerLazySingleton(() => GetUpdateProfileUseCase(sl()));

    sl.registerLazySingleton<BaseUpdateProfileRepository>(
        () => UpdateProfileRepository(sl()));

    sl.registerLazySingleton<BaseUpdateProfileRemoteDataSource>(
        () => UpdateProfileRemoteDataSource(sl()));

    ///////////////////////////////////////////////////////

    sl.registerFactory(() => VerificationCodeCubit(sl()));

    sl.registerLazySingleton(() => GetVerificationCodeUseCase(sl()));

    sl.registerLazySingleton<BaseVerificationCodeRepository>(
        () => VerificationCodeRepository(sl()));

    sl.registerLazySingleton<BaseVerificationCodeRemoteUseCase>(
        () => VerificationCodeRemoteUseCase(sl()));

    //////////////////////////////////////////////////////////
    sl.registerFactory(() => LoginCubit(
          sl(),
          sl(),
          sl(),
        ));

    sl.registerLazySingleton(() => GetLoginUseCase(sl()));

    sl.registerLazySingleton<BaseLoginRepository>(() => LoginRepository(sl()));

    sl.registerLazySingleton<BaseLoginRemoteDataSource>(
        () => LoginRemoteDataSource(sl()));
    /////////////////////////////////////////////////////////

    sl.registerLazySingleton(() => GetResetPasswordUseCase(sl()));

    /////////////////////////////////////////////////////////

    sl.registerLazySingleton(() => GetForgetPasswordUserCase(sl()));
    ////////////////////////////////////////////////////////

    sl.registerFactory(() => RegisterAsADoctorCubit(sl()));

    sl.registerLazySingleton(() => GetRegisterAsADoctorUseCase(sl()));

    sl.registerLazySingleton<BaseRegisterAsADoctorRepository>(
        () => RegisterAsADoctorRepository(sl()));

    sl.registerLazySingleton<BaseRegisterAsADoctorRemoteDataSource>(
        () => RegisterAsADoctorRemoteDataSource(sl()));
    /////////////////////////////////////////////////////////

    sl.registerFactory(() => RegisterCubit(sl()));

    sl.registerLazySingleton(() => GetRegisterUserUseCase(sl()));

    sl.registerLazySingleton<BaseRegisterRepository>(
        () => RegisterRepository(sl()));

    sl.registerLazySingleton<BaseRegisterRemoteDataSource>(
        () => RegisterRemoteDataSource(sl()));

    ////////////////////////////////////////////////////////////
    sl.registerLazySingleton<DioHelper>(
      () => DioHelperImpl(),
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(
      () => sharedPreferences,
    );
  }
}
