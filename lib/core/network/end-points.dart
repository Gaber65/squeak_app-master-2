///todo API
const String baseApiUrl = 'https://207.231.105.243:3002';
const String version = '/v1/api';
const String imageUrl = '$baseApiUrl/files/';

///todo signUp
const String registerEndPoint = '/signUp';
const String registerAsADoctorEndPoint = '/signUp';
const String loginEndPoint = '/signin';
const String verificationCodeEndPoint = '/VerifyUser';
const String forgetPasswordEndPoint = '/ForgetPassword';
const String resetPasswordEndPoint = '/ResetPassword';

///todo pet
const String allSpeciesEndPoint = '/species';
const String allBreedBySpeciesId = '/breed/paggination?SpecieId=';
const String addPetEndPint = '/pets';
const String updatePetEndPint = '/pets/';
const String deletePetEndPint = '/pets/';
const String getOwnerPetEndPoint = '/pets/owner';

///todo Clinic
const String addClinicEndPoint = '/clinics';
const String allClinicEndPoint = '/clinics/paggination';
const String updateClinicEndPoint = '/clinics/';
const String deleteClinicEndPoint = '/clinics/';
const String followClinicEndPoint = '/clinics/follow';
const String unfollowClinicEndPoint = '/clinics/unfollow';
String allClinicFollowerEndPoint(String clinicId) =>
    '/clinics/$clinicId/followers';
const String blockFollowerEndPoint = '/clinics/blockfollower';
const String getFollowerClinicEndPoint = '/owners/followings';
String? clintId;
String? uId = '';
String token = '';
String refreshToken = '';

String password = '';
String email = '';

///todo Vaccination
const String petVacEndPoint = '/petvacs';
const String allVacEndPoint = '/vaccinations/paggination';
const String allVacPetEndPoint = '/petvacs/pet/';

///todo Profile
const String getProfileEndPoint = '/owners';

///todo Speciality
const String allSpecialityPetEndPoint = '/specailiteis';

///todo helper
const String imageHelperEndPoint = '/images';
const String videoHelperEndPoint = '/videos';
const String audioHelperEndPoint = '/audio';

///todo posts
const String createPostEndPoint = '/posts';
String getPostEndPoint(
  int pageNumber,
) {
  return '/posts/user/paggination?pageSize=15&pageNumber=$pageNumber';
}

String getDoctorPostEndPoint(
  int pageNumber,
) {
  return '/posts/doctor/paggination?pageSize=15&pageNumber=$pageNumber';
}

const String deletePostEndPoint = '/posts';
const String updatePostEndPoint = '/posts/';

///todo Comment
const String createCommentEndPoint = '/comments';
const String getCommentEndPoint = '/comments';
const String deleteCommentEndPoint = '/comments/';
const String updateCommentEndPoint = '/comments/';

///todo Contact_us
const String contactUsEndPoint = '/tickets';

///todo Availabilities
const String createAvailabilitiesEndPoint = '/availabilities';
String getAvailabilitiesEndPoint(String clinicId) =>
    '/availabilities/clinic/$clinicId';
String deleteAvailabilitiesEndPoint(String availabilitiesId) =>
    '/availabilities/$availabilitiesId';
String updateAvailabilitiesEndPoint(String availabilitiesId) =>
    '/availabilities/$availabilitiesId';

///todo Appointments
const String createAppointmentsEndPoint = '/appointments';
String getAppointmentsEndPoint = '/appointments/user';
String getAppointmentsDoctorEndPoint = '/appointments/doctor';
String deleteAppointmentsEndPoint(String appointmentsId) =>
    '/appointments/$appointmentsId';
String updateAppointmentsEndPoint(String appointmentsId) =>
    '/appointments/$appointmentsId';

///todo Chat
String sendMassageEndPoint = '/messages';
String getMassageUserEndPoint(String clinicId, int pageNumber) =>
    '/messages/paggination?pageSize=50&pageNumber=$pageNumber&ClinicId=$clinicId';
String getMassageAdminEndPoint({
  required String clinicId,
  required String userId,
  required int pageNumber,
}) {
  return '/messages/paggination?pageSize=50&pageNumber=$pageNumber&UserId=$userId&ClinicId=$clinicId';
}

const String messageKey =
    'key=AAAApN7ozIk:APA91bH9LkCCvQxp57so-6g0QAIGxO2Sd6bTpc2JV1MoysX0NZp0BjggELSJVYOzEVTWsbiQYLQxMC9ON-0tcDsCKeMIOjLAqAx61tRuOMxMvGSE7lFI9qdRM6ZemLVP1sPY8hNzDK9l';
const String baseUrlMessageKey = 'https://fcm.googleapis.com/fcm/send';

String? language;
