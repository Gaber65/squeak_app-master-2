import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD

import '../../../domain/entities/availabilities/get_availabilities_entities.dart';
import '../../../domain/repository/base_availabilities_repository.dart';
import '../../../domain/use_case/availabilities/create_availabilities_use_case.dart';
import '../../../domain/use_case/availabilities/delete_availabilities_use_case.dart';
import '../../../domain/use_case/availabilities/get_availabilities_use_case.dart';
import '../../../domain/use_case/availabilities/update_availabilities_use_case.dart';
import 'availabilities_state.dart';

=======
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/service/service_locator.dart';
import '../../domain/entities/availabilities/get_availabilities_entities.dart';
import '../../domain/repository/base_availabilities_repository.dart';
import '../../domain/use_case/availabilities/create_availabilities_use_case.dart';
import '../../domain/use_case/availabilities/delete_availabilities_use_case.dart';
import '../../domain/use_case/availabilities/get_availabilities_use_case.dart';
import '../../domain/use_case/availabilities/update_availabilities_use_case.dart';

part 'availabilities_state.dart';
>>>>>>> cfea7653adc36927385dfeff26af1e75b2e48eb4

class AvailabilitiesCubit extends Cubit<AvailabilitiesState> {
  AvailabilitiesCubit(
    this.updateAvailabilitiesUseCase,
    this.createAvailabilitiesUseCase,
    this.deleteAvailabilitiesPostUseCase,
    this.getAvailabilitiesPostUseCase,
  ) : super(AvailabilitiesInitial());
  static AvailabilitiesCubit get(context) => BlocProvider.of(context);

  CreateAvailabilitiesUseCase createAvailabilitiesUseCase;
  Future<void> createAvailabilities({
    required int dayOfWeek,
    required String startTime,
    required String endTime,
    required String clinicId,
  }) async {
    emit(CreateAvailabilitiesLoading());
    final result = await createAvailabilitiesUseCase(
      CreateAvailabilitiesParameters(
        dayOfWeek: dayOfWeek,
        startTime: startTime,
        endTime: endTime,
        clinicId: clinicId,
      ),
    );
    result.fold(
      (l) => emit(CreateAvailabilitiesError()),
      (r) => emit(CreateAvailabilitiesSuccess()),
    );
  }

  UpdateAvailabilitiesUseCase updateAvailabilitiesUseCase;
  Future<void> updateAvailabilities({
    required String availabilitiesId,
    required int dayOfWeek,
    required String startTime,
    required String endTime,
    required String clinicId,
  }) async {
    emit(UpdateAvailabilitiesLoading());
    final result = await updateAvailabilitiesUseCase(
      CreateAvailabilitiesParameters(
        dayOfWeek: dayOfWeek,
        startTime: startTime,
        endTime: endTime,
        clinicId: clinicId,
        availabilitiesId: availabilitiesId,
      ),
    );
    result.fold(
      (l) => emit(UpdateAvailabilitiesError()),
      (r) => emit(UpdateAvailabilitiesSuccess()),
    );
  }

  DeleteAvailabilitiesUseCase deleteAvailabilitiesPostUseCase;
  Future<void> deleteAvailabilities({
    required String availabilitiesId,
  }) async {
    emit(DeleteAvailabilitiesLoading());
    final result = await deleteAvailabilitiesPostUseCase(
      GetAvailabilitiesParameters(
        clinicId: availabilitiesId,
      ),
    );
    result.fold(
      (l) => emit(DeleteAvailabilitiesError()),
      (r) => emit(DeleteAvailabilitiesSuccess()),
    );
  }

  GetAvailabilitiesUseCase getAvailabilitiesPostUseCase;
  GetAvailabilitiesEntities? availabilitiesEntities;
  Future<void> getAvailabilities({
    required String clinicId,
  }) async {
    emit(GetAvailabilitiesLoading());
    final result = await getAvailabilitiesPostUseCase(
      GetAvailabilitiesParameters(
        clinicId: clinicId,
      ),
    );
    result.fold((l) => emit(GetAvailabilitiesError()), (r) {
      availabilitiesEntities = r;
<<<<<<< HEAD
      print(r);
=======
>>>>>>> cfea7653adc36927385dfeff26af1e75b2e48eb4
      emit(GetAvailabilitiesSuccess(r));
    });
  }
}
