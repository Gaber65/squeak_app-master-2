import 'package:dartz/dartz.dart';
import 'package:squeak/core/error/failure.dart';
import 'package:squeak/features/setting/profile/domain/entities/profile.dart';

import '../entities/contact_us_entites.dart';
import '../usecase/post_contactUs_use_case.dart';


abstract class BaseProfileRepository
{

  Future<Either<Failure,Profile>>getProfile();
  Future<Either<Failure,ContactUsEntites>>postContactUs(TicketParameters parameters );

}