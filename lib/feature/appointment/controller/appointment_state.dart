abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

///todo add appointment
class AddAppointmentLoading extends AppointmentState {}

class AddAppointmentSuccess extends AppointmentState {}

class AddAppointmentError extends AppointmentState {}

///todo cancled appoinment
class AddCancledAppointmentLoading extends AppointmentState {}

class AddCancledAppointmentSuccess extends AppointmentState {}

class AddCancledAppointmentError extends AppointmentState {}

///todo complete appoinment
class AddCompleteAppointmentLoading extends AppointmentState {}

class AddCompleteAppointmentSuccess extends AppointmentState {}

class AddCompleteAppointmentError extends AppointmentState {}

///todo Get appointment
class GetAppointmentLoading extends AppointmentState {}

class GetAppointmentSuccess extends AppointmentState {}

class GetAppointmentError extends AppointmentState {}

///todo Delete appointment
class DeleteAppointmentLoading extends AppointmentState {}

class DeleteAppointmentSuccess extends AppointmentState {}

class DeleteAppointmentError extends AppointmentState {}

///todo Update appointment
class UpdateAppointmentLoading extends AppointmentState {}

class UpdateAppointmentSuccess extends AppointmentState {}

class UpdateAppointmentError extends AppointmentState {}
