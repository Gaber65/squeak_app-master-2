import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../base_repository/chat_base_repo.dart';
import '../entities/create_message_entities.dart';

class SendMessageUseCase extends BaseUseCase<CreateMessageEntities, CreateMassageParameter> {
  final ChatBaseRepository chatBaseRepository;

  SendMessageUseCase(this.chatBaseRepository);


  @override
  Future<Either<Failure, CreateMessageEntities>> call(
      CreateMassageParameter parameters) async {
    return await chatBaseRepository.createMassage(parameters);
  }
}
