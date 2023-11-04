import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/dio.dart';

import 'package:squeak/features/authentication/register/verficiation/data/datasource/base_verification_code_remote_use_case.dart';
import 'package:squeak/features/authentication/register/verficiation/data/repository/verification_code_repository.dart';
import 'package:squeak/features/authentication/register/verficiation/domain/repository/base_verification_code_repository.dart';
import 'package:squeak/features/authentication/register/verficiation/domain/usecase/get_verification_code_use_case.dart';
import 'package:squeak/features/authentication/register/verficiation/presentation/controller/cubit/ver_cubit.dart';
import 'package:squeak/features/availability/domain/use_case/appointments/get_doctor_appointment_use_case.dart';
import 'package:squeak/features/layout/domain/use_case/clinic/get_all_clinics_use_case.dart';
import 'package:squeak/features/layout/domain/use_case/post_use_case/get_clinic_post_use_case.dart';
import 'package:squeak/features/social_media/presentation/controller/phone_cubit/phone_cubit.dart';

import '../../features/authentication/login/data/datasource/base_login_remote_data_source.dart';
import '../../features/authentication/login/data/repository/login_repository.dart';
import '../../features/authentication/login/domain/repository/base_auth_repository.dart';
import '../../features/authentication/login/domain/usecase/get_froget_password_use_case.dart';
import '../../features/authentication/login/domain/usecase/get_login_use_case.dart';
import '../../features/authentication/login/domain/usecase/get_reset_password_use_case.dart';
import '../../features/authentication/register/register_as_a_doctor/domain/usecase/sign_in.dart';
import '../../features/authentication/login/presentation/controller/cubit/login_cubit.dart';
import '../../features/authentication/register/register_as_a_doctor/data/datasource/base_register_as_a_doctor_remote_data_source.dart';
import '../../features/authentication/register/register_as_a_doctor/data/repository/register_as_a_doctor_repository.dart';
import '../../features/authentication/register/register_as_a_doctor/domain/repository/base_register_as_a_doctor.dart';
import '../../features/authentication/register/register_as_a_doctor/domain/usecase/get_register_as_a_doctor_use_case.dart';
import '../../features/authentication/register/register_as_a_doctor/domain/usecase/create_user_use_case.dart';
import '../../features/authentication/register/register_as_a_doctor/domain/usecase/sign_up.dart';
import '../../features/authentication/register/register_as_a_doctor/presentation/controller/cubit/register_as_a_doctor_cubit.dart';
import '../../features/authentication/register/register_as_a_user/data/datasource/base_register_remote_data_source.dart';
import '../../features/authentication/register/register_as_a_user/data/repository/register_repository.dart';
import '../../features/authentication/register/register_as_a_user/domain/repository/base_register_repository.dart';
import '../../features/authentication/register/register_as_a_user/domain/usecase/get_register_user_use_case.dart';
import '../../features/authentication/register/register_as_a_user/presentation/controller/cubit/register_cubit.dart';
import '../../features/availability/data/data_source/availabilities_data_source.dart';
import '../../features/availability/data/repository/availabilities_repo.dart';
import '../../features/availability/domain/repository/base_availabilities_repository.dart';
import '../../features/availability/domain/use_case/Appointments/create_Appointments_use_case.dart';
import '../../features/availability/domain/use_case/Appointments/delete_Appointments_use_case.dart';
import '../../features/availability/domain/use_case/Appointments/get_Appointments_use_case.dart';
import '../../features/availability/domain/use_case/Appointments/update_Appointments_use_case.dart';
import '../../features/availability/domain/use_case/availabilities/create_availabilities_use_case.dart';
import '../../features/availability/domain/use_case/availabilities/delete_availabilities_use_case.dart';
import '../../features/availability/domain/use_case/availabilities/get_availabilities_use_case.dart';
import '../../features/availability/domain/use_case/availabilities/update_availabilities_use_case.dart';
import '../../features/availability/presentation/control/appointments/appointments_cubit.dart';
import '../../features/availability/presentation/control/availabilities/availabilities_cubit.dart';
import '../../features/comment/date/data_source/base_comment_data_source.dart';
import '../../features/comment/date/repository/comment_repository.dart';
import '../../features/comment/domain/repository/base_comment_repository.dart';
import '../../features/comment/domain/usecase/create_comment_use_case.dart';
import '../../features/comment/domain/usecase/delete_comment_use_case.dart';
import '../../features/comment/domain/usecase/get_comment_replies_use_case.dart';
import '../../features/comment/domain/usecase/get_comment_use_case.dart';
import '../../features/comment/domain/usecase/update_comment_use_case.dart';
import '../../features/comment/presentation/controller/comment_cubit.dart';
import '../../features/layout/data/data_source/base_clinic_data_source.dart';
import '../../features/layout/data/repository/clinic_repo.dart';
import '../../features/layout/domain/base_repository/base_clinic_repo.dart';
import '../../features/layout/domain/use_case/clinic/add_clinic_use_case.dart';
import '../../features/layout/domain/use_case/clinic/all_clinic_supllier.dart';
import '../../features/layout/domain/use_case/clinic/block_follow_user_use_cse.dart';
import '../../features/layout/domain/use_case/clinic/delete_clinic_use_case.dart';
import '../../features/layout/domain/use_case/clinic/get_all_clinic_follow.dart';
import '../../features/layout/domain/use_case/clinic/get_all_specialities_use_case.dart';
import '../../features/layout/domain/use_case/clinic/get_follower_clinic_use_case.dart';
import '../../features/layout/domain/use_case/clinic/post_follow_clinic.dart';
import '../../features/layout/domain/use_case/clinic/post_unfollow_clinic.dart';
import '../../features/layout/domain/use_case/clinic/update_clinic_use_case.dart';
import '../../features/layout/domain/use_case/post_use_case/add_clinic_post_use_case.dart';
import '../../features/layout/domain/use_case/post_use_case/delete_clinic_post_use_case.dart';
import '../../features/layout/domain/use_case/post_use_case/get_doctor_posts_use_case.dart';
import '../../features/layout/domain/use_case/post_use_case/update_clinic_post_use_case.dart';
import '../../features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import '../../features/layout/presentation/controller/notification_cubit/notification_cubit.dart';
import '../../features/layout/presentation/controller/post_cubit/post_cubit.dart';
import '../../features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import '../../features/layout/presentation/screens/vaccination/vac_cubit/vaccination_cubit.dart';
import '../../features/setting/profile/data/datasource/base_profile_remote_data_source.dart';
import '../../features/setting/profile/data/repository/profile_repository.dart';
import '../../features/setting/profile/domain/repository/base_profile_repository.dart';
import '../../features/setting/profile/domain/usecase/post_contactUs_use_case.dart';
import '../../features/setting/profile/presentation/Contact_us/contact_us_cubit.dart';
import '../../features/setting/update_profile/domain/usecase/add_vac_pet_use_case.dart';
import '../../features/setting/update_profile/domain/usecase/delete_pet_use_case.dart';
import '../../features/setting/update_profile/domain/usecase/get_all_vac_use_case.dart';
import '../../features/setting/update_profile/domain/usecase/get_owner_pets.dart';
import '../../features/setting/profile/domain/usecase/get_profile_user_use_case.dart';

import '../../features/setting/update_profile/data/datasource/base_update_profile_data_source.dart';
import '../../features/setting/update_profile/data/repository/update_profile_repository.dart';
import '../../features/setting/update_profile/domain/repository/base_update_profile_repository.dart';
import '../../features/setting/update_profile/domain/usecase/get_all_species_use_cse.dart';
import '../../features/setting/update_profile/domain/usecase/get_breed_by_speciesId_use_case.dart';
import '../../features/setting/update_profile/domain/usecase/get_update_profile_use_case.dart';
import '../../features/setting/update_profile/domain/usecase/get_vac_by_pet_id.dart';
import '../../features/setting/update_profile/domain/usecase/post_pets_use_case.dart';
import '../../features/setting/update_profile/domain/usecase/update_pits_use_case.dart';
import '../../features/setting/update_profile/presentation/controlls/cubit/add_edit_beets_cubit.dart';
import '../../features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../../features/social_media/data/data_source/chat_data_source.dart';
import '../../features/social_media/data/repository/chat_repo.dart';
import '../../features/social_media/domain/base_repository/chat_base_repo.dart';
import '../../features/social_media/domain/use_case/create_admin_massage_use_case.dart';
import '../../features/social_media/domain/use_case/get_Notifications_use_case.dart';
import '../../features/social_media/domain/use_case/get_receiver_massage_use_case.dart';
import '../../features/social_media/domain/use_case/get_sender_massage_use_case.dart';
import '../../features/social_media/domain/use_case/get_user.dart';
import '../../features/social_media/domain/use_case/send_message_use_case.dart';
import '../../features/social_media/domain/use_case/send_notification_use_case.dart';
import '../../features/social_media/presentation/controller/chat_cubit.dart';
import '../network/helper/helper_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    //Todo: cubit services locator
    sl.registerFactory(() => SqueakCubit(sl(), sl(), sl()));
    sl.registerFactory(() => ChatCubit(sl(), sl(),sl(), sl(),sl()));
    sl.registerFactory(() => PhoneCubit(
          sl(),
        ));
    sl.registerFactory(() => HelperCubit());
    sl.registerFactory(() => AvailabilitiesCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => LoginCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => RegisterAsADoctorCubit(sl(), sl(), sl()));
    sl.registerFactory(() => VerificationCodeCubit(sl()));
    sl.registerFactory(() => ContactUsCubit(sl()));
    sl.registerFactory(() => RegisterCubit(
          sl(),
          sl(),
          sl(),
        ));
    sl.registerFactory(() => VaccinationCubit(sl(), sl()));
    sl.registerFactory(() => NotificationCubit(sl()));
    sl.registerFactory(() => AddBeetsCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => PostCubit(sl(), sl(), sl(), sl(), sl()));
    sl.registerFactory(() => BreedsTypeCubit(sl(), sl()));
    sl.registerFactory(() => CommentCubit(sl(), sl(), sl(), sl(), sl()));
    sl.registerFactory(() => AppointmentsCubit(sl(), sl(), sl(), sl(), sl()));
    sl.registerFactory(() => ClinicCubit(
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
        ));

    //Todo: use Case services locator
    sl.registerLazySingleton(() => PostPetsUseCase(sl()));
    sl.registerLazySingleton(() => PostContactUsUseCase(sl()));
    sl.registerLazySingleton(() => GetOwnerPetsUseCase(sl()));
    sl.registerLazySingleton(() => UpdatePetsUseCase(sl()));
    sl.registerLazySingleton(() => SendMessageUseCase(sl()));
    sl.registerLazySingleton(() => SendNotificationUseCase(sl()));
    sl.registerLazySingleton(() => GetProfileUseCase(sl()));
    sl.registerLazySingleton(() => GetUpdateProfileUseCase(sl()));
    sl.registerLazySingleton(() => GetVerificationCodeUseCase(sl()));
    sl.registerLazySingleton<BaseVerificationCodeRemoteUseCase>(
        () => VerificationCodeRemoteUseCase());
    sl.registerLazySingleton(() => GetLoginUseCase(sl()));
    sl.registerLazySingleton(() => GetResetPasswordUseCase(sl()));
    sl.registerLazySingleton(() => GetForgetPasswordUserCase(sl()));
    sl.registerLazySingleton(() => GetRegisterAsADoctorUseCase(sl()));
    sl.registerLazySingleton(() => CreateUserUseCase(sl()));
    sl.registerLazySingleton(() => GetRegisterUserUseCase(sl()));
    sl.registerLazySingleton(() => AddClinicUseCase(sl()));
    sl.registerLazySingleton(() => GetAllClinicUseCase(sl()));
    sl.registerLazySingleton(() => PostFollowClinicUseCase(sl()));
    sl.registerLazySingleton(() => PostUnFollowClinicUseCase(sl()));
    sl.registerLazySingleton(() => GetAllClinicFollowUseCase(sl()));
    sl.registerLazySingleton(() => GetAllSpeciesUseCase(sl()));
    sl.registerLazySingleton(() => GetBreedBySpeciesIdUseCase(sl()));
    sl.registerLazySingleton(() => GetAllVacUseCase(sl()));
    sl.registerLazySingleton(() => PostVacPetsUseCase(sl()));
    sl.registerLazySingleton(() => DeletePetsUseCase(sl()));
    sl.registerLazySingleton(() => GetAllVacPetUseCase(sl()));
    sl.registerLazySingleton(() => GetAllSpecialityUseCase(sl()));
    sl.registerLazySingleton(() => PostBlockUserFollowClinicUseCase(sl()));
    sl.registerLazySingleton(() => CreatePostClinicUseCase(sl()));
    sl.registerLazySingleton(() => DeletePostClinicUseCase(sl()));
    sl.registerLazySingleton(() => GetPostClinicUseCase(sl()));
    sl.registerLazySingleton(() => UpdatePostClinicUseCase(sl()));
    sl.registerLazySingleton(() => GetAllSupplierClinicUseCase(sl()));
    sl.registerLazySingleton(() => UpdateClinicUseCase(sl()));
    sl.registerLazySingleton(() => DeleteClinicUseCase(sl()));
    sl.registerLazySingleton(() => GetDoctorPostClinicUseCase(sl()));
    sl.registerLazySingleton(() => GetAllFollowerClinicUseCase(sl()));
    sl.registerLazySingleton(() => UpdateCommentUseCase(sl()));
    sl.registerLazySingleton(() => GetCommentPostUseCase(sl()));
    sl.registerLazySingleton(() => DeleteCommentPostUseCase(sl()));
    sl.registerLazySingleton(() => CreateCommentUseCase(sl()));
    sl.registerLazySingleton(() => CreateAvailabilitiesUseCase(sl()));
    sl.registerLazySingleton(() => DeleteAvailabilitiesUseCase(sl()));
    sl.registerLazySingleton(() => GetAvailabilitiesUseCase(sl()));
    sl.registerLazySingleton(() => UpdateAvailabilitiesUseCase(sl()));
    sl.registerLazySingleton(() => CreateAppointmentsUseCase(sl()));
    sl.registerLazySingleton(() => DeleteAppointmentsUseCase(sl()));
    sl.registerLazySingleton(() => GetAppointmentsUseCase(sl()));
    sl.registerLazySingleton(() => UpdateAppointmentsUseCase(sl()));
    sl.registerLazySingleton(() => SignInUseCase(sl()));
    sl.registerLazySingleton(() => SignUpUseCase(sl()));
    sl.registerLazySingleton(() => GetUserDataUseCase(sl()));
    sl.registerLazySingleton(() => GetCommentRepliesPostUseCase(sl()));
    sl.registerLazySingleton(() => GetDoctorAppointmentsUseCase(sl()));
    sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
    sl.registerLazySingleton(() => GetAdminMassageUseCase(sl()));
    sl.registerLazySingleton(() => GetUserMassageUseCase(sl()));
    sl.registerLazySingleton(() => SendMessageAdminUseCase(sl()));

    //Todo: Repository services locator
    sl.registerLazySingleton<ChatBaseRepository>(() => ChatRepo(sl()));
    sl.registerLazySingleton<BaseProfileRepository>(
        () => ProfileRepository(sl()));
    sl.registerLazySingleton<BaseUpdateProfileRepository>(
        () => UpdateProfileRepository(sl()));
    sl.registerLazySingleton<BaseVerificationCodeRepository>(
        () => VerificationCodeRepository(sl()));
    sl.registerLazySingleton<BaseLoginRepository>(() => LoginRepository(sl()));
    sl.registerLazySingleton<BaseRegisterAsADoctorRepository>(
        () => RegisterAsADoctorRepository(sl()));
    sl.registerLazySingleton<BaseRegisterRepository>(
        () => RegisterRepository(sl()));
    sl.registerLazySingleton<BaseClinicRepo>(() => ClinicRepository(sl()));
    sl.registerLazySingleton<BaseCommentRepository>(
        () => CommentRepository(sl()));
    sl.registerLazySingleton<BaseAvailabilitiesRepository>(
        () => AvailabilitiesRepository(sl()));

    //Todo: Data source services locator
    sl.registerLazySingleton<ChatBaseRemoteDataSource>(
        () => ChatRemoteDataSource());
    sl.registerLazySingleton<BaseProfileRemoteDataSource>(
        () => ProfileRemoteDataSource());
    sl.registerLazySingleton<BaseUpdateProfileRemoteDataSource>(
        () => UpdateProfileRemoteDataSource());
    sl.registerLazySingleton<BaseLoginRemoteDataSource>(
        () => LoginRemoteDataSource());
    sl.registerLazySingleton<BaseRegisterAsADoctorRemoteDataSource>(
        () => RegisterAsADoctorRemoteDataSource());
    sl.registerLazySingleton<BaseRegisterRemoteDataSource>(
        () => RegisterRemoteDataSource());
    sl.registerLazySingleton<BaseClinicRemoteDataSource>(
        () => ClinicRemoteDataSource());
    sl.registerLazySingleton<BaseCommentRemoteDataSource>(
        () => CommentRemoteDataSource());
    sl.registerLazySingleton<BaseAvailabilitiesRemoteDataSource>(
        () => AvailabilitiesRemoteDataSource());

    ////////////////////////////////////////////////////////////
    sl.registerLazySingleton<DioFinalHelper>(
      () => DioFinalHelper(),
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(
      () => sharedPreferences,
    );

    /////////////////////////////////////////////
  }
}
