import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String body;
  final String time;
  final String title;

  const NotificationModel({
    required this.body,
    required this.time,
    required this.title,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      body: json['body'],
      time: json['time'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'time': time,
      'title': title,
    };
  }

  @override
  List<Object> get props => [
        body,
        time,
        title,
      ];
}
