import 'package:equatable/equatable.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../base_repository/chat_base_repo.dart';

class SendNotificationUseCase
    extends BaseUseCase2<void, SendNotificationParameters> {
  final ChatBaseRepository chatBaseRepository;

  SendNotificationUseCase(this.chatBaseRepository);

  @override
  Future<void> call(SendNotificationParameters parameters) async {
    return await chatBaseRepository.sendNotification(parameters);
  }
}

class SendNotificationParameters extends Equatable {
  final String title;
  final String body;
  final String deviceToken;
  const SendNotificationParameters(
      {required this.title, required this.body, required this.deviceToken});

  @override
  List<Object?> get props => [
        title,
        body,
        deviceToken,
      ];
}
