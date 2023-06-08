import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final bool? status;
  final String? message;
  final ProfileData? data;

  const Profile({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}

class ProfileData extends Equatable {
  final Owner? owner;

  const ProfileData({
    required this.owner,
  });

  @override
  List<Object?> get props => [
        owner,
      ];
}

class Owner extends Equatable {
  final String? clientId;
  final String? fullname;
  final String? email;
  final String? phone;
  final String? addresss;
  final String? imageName;
  final String? birthdat;
  final dynamic gender;
  final int? locked;
  final int? role;
  final String? language;


  const Owner({
   required this.clientId,
   required this.fullname,
   required this.email,
   required this.phone,
   required this.addresss,
   required this.imageName,
   required this.birthdat,
   required this.gender,
   required this.locked,
   required this.role,
   required this.language,

  });

  @override
  List<Object?> get props => [
    clientId,
    fullname,
    email,
    phone,
    addresss,
    imageName,
    birthdat,
    gender,
    locked,
    role,
    language,

  ];
}
