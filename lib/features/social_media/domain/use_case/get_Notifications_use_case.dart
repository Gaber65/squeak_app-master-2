import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/setting/profile/domain/entities/profile.dart';
import 'package:squeak/features/setting/profile/domain/repository/base_profile_repository.dart';

import '../base_repository/chat_base_repo.dart';
import '../entities/notifications_entities.dart';

class GetNotificationsUseCase extends BaseUseCase<NotificationsEntities,NoParameters>
{
  final ChatBaseRepository chatBaseRepository;

  GetNotificationsUseCase(this.chatBaseRepository);
  @override
  Future<Either<Failure, NotificationsEntities>> call(NoParameters parameters)async {
    return await chatBaseRepository.getNotification();
  }

}