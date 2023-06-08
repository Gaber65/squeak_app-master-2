import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/error/failure.dart';
import '../entities/update_profile.dart';

abstract class BaseUpdateProfileRepository {
  Future<Either<Failure, UpdateProfile>> getUpdateProfile(UpdateProfileParameters parameters);
}

class UpdateProfileParameters extends Equatable {
  final String fullName;
  final String phone;
  final String email;
  final String addresss;
  final String Birthdate;
  final String Imagepath;
  final String image;
  final String gender;

  const UpdateProfileParameters({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.Birthdate,
    required this.Imagepath,
    required this.addresss,
    required this.image,
    required this.gender,
  });

  @override
  List<Object?> get props => [
   fullName,
   phone,
   email,
   addresss,
   image,
   gender, Birthdate,Imagepath
  ];
}
