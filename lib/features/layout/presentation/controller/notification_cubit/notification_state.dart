part of 'notification_cubit.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}


class GetNotificationLoading extends NotificationState {}
class GetNotificationSuccess extends NotificationState {}
class GetNotificationError extends NotificationState {}
