import 'package:equatable/equatable.dart';

class NotificationsEntities extends Equatable {
  NotificationsData? data;
  dynamic message;
  int statusCode;

  NotificationsEntities({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [statusCode, data, statusCode];
}

class NotificationsData extends Equatable {
  final int count;
  final List<Notifications> notifications;

  const NotificationsData({
    required this.notifications,
    required this.count,
  });

  @override
  List<Object> get props => [notifications];
}

class Notifications extends Equatable {
  final String message;
  final bool isRead;
  final String createdAt;
  final String entityType;

  const Notifications({
    required this.message,
    required this.entityType,
    required this.isRead,
    required this.createdAt,
  });

  @override
  List<Object> get props => [
        message,
        isRead,
        createdAt,
        entityType,
      ];
}
