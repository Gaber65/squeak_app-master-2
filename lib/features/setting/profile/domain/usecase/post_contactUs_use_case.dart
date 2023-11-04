import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/setting/profile/domain/repository/base_profile_repository.dart';

import '../entities/contact_us_entites.dart';

class PostContactUsUseCase extends BaseUseCase<ContactUsEntites, TicketParameters> {
  final BaseProfileRepository baseProfileRepository;

  PostContactUsUseCase(this.baseProfileRepository);
  @override
  Future<Either<Failure, ContactUsEntites>> call(TicketParameters parameters) async {
    return await baseProfileRepository.postContactUs(parameters);
  }
}

class TicketParameters extends Equatable {
  const TicketParameters({
    required this.title,
    required this.phone,
    required this.comment,
    required this.email,
    required this.statues,
    required this.fullName,
  });

  final String title;
  final String phone;
  final String comment;
  final String email;
  final String fullName;
  final bool statues;

  @override
  List<Object?> get props => [
    title,
    phone,
    comment,
    email,
    statues,fullName
  ];
}
