import '../../domain/entities/notifications_entities.dart';

class NotificationsModel extends NotificationsEntities {


  NotificationsModel({
    required super.statusCode,
    required super.message,
    required super.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      statusCode: json['statusCode'],
      message: json['message'],
      data: NotificationsDataModel.fromJson(json['data']),
    );
  }

}

class NotificationsDataModel extends NotificationsData {
  const NotificationsDataModel({
    required super.notifications,
    required super.count,
  });

  factory NotificationsDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationsDataModel(
      count: json['count'],
      notifications: List.from(json['notificationDtos'])
          .map((e) => NotificationsMo.fromJson(e))
          .toList(),
    );
  }
}

class NotificationsMo extends Notifications {
  const NotificationsMo({
    required super.message,
    required super.entityType,
    required super.isRead,
    required super.createdAt,
  });
  factory NotificationsMo.fromJson(Map<String, dynamic> json) {
    return NotificationsMo(
      message: json['message'],
      entityType: json['entityType'],
      isRead: json['isRead'],
      createdAt: json['createdAt'],
    );
  }
}
