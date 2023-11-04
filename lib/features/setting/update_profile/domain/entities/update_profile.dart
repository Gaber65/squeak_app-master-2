import 'package:equatable/equatable.dart';

class UpdateProfile extends Equatable {
  final bool? status;
  final String? message;
  final UpdateProfileData? data;

  const UpdateProfile({
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

class UpdateProfileData extends Equatable {
  final UpdateProfileOwner? owner;

  const UpdateProfileData({
    required this.owner,
  });

  @override
  List<Object?> get props => [
        owner,
      ];
}

class UpdateProfileOwner extends Equatable {
  final String? clientId;
  final String? fullname;
  final String? email;
  final String? phone;
  final String? addresss;
  final String? imageName;
  final dynamic? gender;
  final int? locked;
  final int? role;

  const UpdateProfileOwner({
    required this.clientId,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.addresss,
    required this.imageName,
    required this.gender,
    required this.locked,
    required this.role,
  });

  @override
  List<Object?> get props => [
    clientId,
    fullname,
    email,
    phone,
    addresss,
    imageName,
    gender,
    locked,
    role,
  ];
}
