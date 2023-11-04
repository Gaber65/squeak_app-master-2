import 'package:dartz/dartz.dart';

import 'package:squeak/core/error/failure.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../base_repository/chat_base_repo.dart';
import '../entities/get_massage_entities.dart';

class GetUserMassageUseCase extends BaseUseCase<GetMassageEntities, GetMassageParameter>{
  final ChatBaseRepository chatBaseRepository;

  GetUserMassageUseCase(this.chatBaseRepository);

  @override
  Future<Either<Failure, GetMassageEntities>> call(GetMassageParameter parameters) async {
    return await chatBaseRepository.getUserMassage(parameters);
  }


}