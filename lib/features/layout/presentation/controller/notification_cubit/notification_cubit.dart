import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/social_media/domain/entities/notifications_entities.dart';
import 'package:squeak/features/social_media/domain/use_case/get_Notifications_use_case.dart';

import '../../../../../core/network/end-points.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.getNotificationsUseCase)
      : super(NotificationInitial());

  static NotificationCubit get(context) => BlocProvider.of(context);

  NotificationsEntities? notificationModel;
  GetNotificationsUseCase getNotificationsUseCase;
  Future<void> getNotification() async {
    emit(GetNotificationLoading());

    final result = await getNotificationsUseCase(const NoParameters());

    result.fold((l) {
      emit(GetNotificationError());
    }, (r) {
      emit(GetNotificationSuccess());
      notificationModel = r;
      print(r);
    });
  }
}
