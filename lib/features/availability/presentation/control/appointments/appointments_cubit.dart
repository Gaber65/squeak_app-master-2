import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/availability/domain/use_case/appointments/get_doctor_appointment_use_case.dart';

import '../../../domain/entities/Appointments/get_Appointments_entities.dart';
import '../../../domain/repository/base_availabilities_repository.dart';
import '../../../domain/use_case/Appointments/create_Appointments_use_case.dart';
import '../../../domain/use_case/Appointments/delete_Appointments_use_case.dart';
import '../../../domain/use_case/Appointments/get_Appointments_use_case.dart';
import '../../../domain/use_case/Appointments/update_Appointments_use_case.dart';
import 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit(
    this.updateAppointmentsUseCase,
    this.createAppointmentsUseCase,
    this.deleteAppointmentsPostUseCase,
    this.getAppointmentsPostUseCase,
    this.doctorAppointmentsUseCase,
  ) : super(AppointmentsInitial());
  static AppointmentsCubit get(context) => BlocProvider.of(context);

  CreateAppointmentsUseCase createAppointmentsUseCase;
  Future<void> createAppointments({
    required String petId,
    required String doctorId,
    required String availabilityId,
    required String visitComment,
    required String appointmentTime,
    required String appointmentDate,
  }) async {
    emit(CreateAppointmentsLoading());
    final result = await createAppointmentsUseCase(
      CreateAppointmentsParameters(
        petId: petId,
        doctorId: doctorId,
        availabilityId: availabilityId,
        visitComment: visitComment,
        appointmentDate: appointmentDate,
        appointmentTime: appointmentTime,
        status: 0,
      ),
    );
    result.fold(
      (l) => emit(CreateAppointmentsError()),
      (r) => emit(CreateAppointmentsSuccess(r)),
    );
  }

  UpdateAppointmentsUseCase updateAppointmentsUseCase;
  Future<void> updateAppointments({
    required String petId,
    required String doctorId,
    required String availabilityId,
    required String visitComment,
    required String appointmentTime,
    required String appointmentDate,
    required String appointmentsId,
  }) async {
    emit(UpdateAppointmentsLoading());
    final result = await updateAppointmentsUseCase(
      CreateAppointmentsParameters(
        petId: petId,
        doctorId: doctorId,
        availabilityId: availabilityId,
        visitComment: visitComment,
        appointmentDate: appointmentDate,
        appointmentTime: appointmentTime,
        status: 0,
        appointmentsId: appointmentsId,
      ),
    );
    result.fold(
      (l) => emit(UpdateAppointmentsError()),
      (r) => emit(UpdateAppointmentsSuccess()),
    );
  }

  DeleteAppointmentsUseCase deleteAppointmentsPostUseCase;
  Future<void> deleteAppointments({
    required String appointmentsId,
  }) async {
    emit(DeleteAppointmentsLoading());
    final result = await deleteAppointmentsPostUseCase(
      DeleteAppointmentsParameters(
        appointmentsId: appointmentsId,
      ),
    );
    result.fold(
      (l) => emit(DeleteAppointmentsError()),
      (r) => emit(DeleteAppointmentsSuccess()),
    );
  }

  GetAppointmentsUseCase getAppointmentsPostUseCase;
  GetAppointmentsEntities? appointmentsEntities;
  Future<void> getAppointments() async {
    emit(GetAppointmentsLoading());
    final result = await getAppointmentsPostUseCase(const NoParameters());
    result.fold((l) => emit(GetAppointmentsError()), (r) {
      appointmentsEntities = r;
      print("Apointment$r");
      emit(GetAppointmentsSuccess(r));
    });
  }
  GetDoctorAppointmentsUseCase doctorAppointmentsUseCase;

  GetAppointmentsEntities? appointmentsDoctorEntities;
  Future<void> getDoctorAppointments() async {
    emit(GetAppointmentsLoading());
    final result = await doctorAppointmentsUseCase(const NoParameters());
    result.fold((l) => emit(GetAppointmentsError()), (r) {
      appointmentsDoctorEntities = r;
      print(appointmentsDoctorEntities);
      print("Apointment$r");
      emit(GetAppointmentsSuccess(r));
    });
  }
}
