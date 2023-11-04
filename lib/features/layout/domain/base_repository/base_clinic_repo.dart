import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../availability/domain/entities/availabilities/delete_availabilities_entities.dart';
import '../entites/clinic/add_clinic_entities.dart';
import '../entites/clinic/all_clinic_follower.dart';
import '../entites/clinic/all_clinics_entities.dart';

import '../entites/clinic/follow_clinic.dart';
import '../entites/clinic/get_follower_clinic_entities.dart';
import '../entites/clinic/speciality_entities.dart';
import '../entites/post/create_post_entites.dart';
import '../entites/post/get_doctor_post_entitites.dart';
import '../entites/vac/vaccination_entities.dart';
import '../use_case/post_use_case/get_doctor_posts_use_case.dart';

abstract class BaseClinicRepo {
  ///todo ClinicAllClinicEntities
  Future<Either<Failure, AddClinicEntities>> addClinic(AddClinicParameters parameters);
  //search
  Future<Either<Failure, AllClinicEntities>> allClinic(AllFollowClinicParameters parameters);
  Future<Either<Failure, AllClinicEntities>> updateClinic(AddClinicParameters parameters);
  Future<Either<Failure, DeleteAvailabilitiesEntities>> deleteClinic(FollowClinicParameters parameters);
  Future<Either<Failure, SpecialitiesEntities>> allSpecialities();
  //get follow to clinic
  Future<Either<Failure, AllClinicFollowerEntities>> allFollowClinic(AllFollowClinicParameters parameters);
  //get follow to clinic
  Future<Either<Failure, AllClinicEntities>> allClinicSupplier(AllFollowClinicParameters parameters);
  Future<Either<Failure, FollowEntites>> followClinic(FollowClinicParameters parameters);
  Future<Either<Failure, FollowEntites>> unfollowClinic(FollowClinicParameters parameters);
  Future<Either<Failure, FollowEntites>> blockFollowUser(BlockUserClinicParameters parameters);
  Future<Either<Failure, ClinicFollowersEntities>> getFollowersClinic();

  ///todo Vaccination
  Future addVaccination(VaccinationParameters parameters);

  Future<Either<Failure, VaccinationEntities>> getVaccinationPet(VaccinationParameters parameters);
  Future<Either<Failure, VaccinationEntities>> updateVaccination(VaccinationParameters parameters);
  Future<Either<Failure, VaccinationNameEntities>> getVaccinationName(VaccinationNameParameters parameters);

  ///todo Create Post
  Future<Either<Failure, PostEntities>> createPostClinic(AddPostParameters parameters);
  Future<Either<Failure, PostDoctorEntities>> getClinicPosts(GetPostParameters parameters);
  Future<Either<Failure, PostDoctorEntities>> getDoctorPosts(GetPostParameters getPostParameters);
  Future<Either<Failure, PostEntities>> updatePostClinic(AddPostParameters parameters);
  Future<Either<Failure, PostEntities>> deletePostClinic(AddPostParameters parameters);
}

class AddClinicParameters extends Equatable {
  final String name;
  final String location;
  final String city;
  final String address;
  final String phone;
  final String speciality;
  final String code;
  final String image;
  final String? clinicId;

  const AddClinicParameters({
    required this.name,
    required this.location,
    required this.city,
    required this.address,
    required this.phone,
    required this.speciality,
    required this.image,
    required this.code,
    this.clinicId
  });

  @override
  List<Object> get props => [
        name,
        location,
        city,
        address,
        phone,
        image,
        speciality,code,
      ];
}

class FollowClinicParameters extends Equatable {
  final String clinicId;

  const FollowClinicParameters(this.clinicId);

  @override
  List<Object> get props => [clinicId];
}

class AllFollowClinicParameters extends Equatable {
  final String adminId;

  const AllFollowClinicParameters(this.adminId);

  @override
  List<Object> get props => [adminId];
}

class VaccinationParameters extends Equatable {
  final String vacName;
  final String vacDate;
  final String vacTime;
  final String vacComment;
  final String petId;
  final String vacId;
  final bool vacState;

  const VaccinationParameters({
    required this.vacName,
    required this.vacDate,
    required this.vacTime,
    required this.vacComment,
    required this.vacState,
    required this.petId,
    required this.vacId,
  });

  @override
  List<Object> get props => [
        vacName,
        vacDate,
        vacTime,
        vacComment,
        petId,
        vacState,
        vacId,
      ];
}

class VaccinationNameParameters extends Equatable {
  String vacName;
  String vacID;

  VaccinationNameParameters({
    required this.vacName,
    required this.vacID,
  });

  @override
  List<Object> get props => [];
}

class AddPostParameters extends Equatable {
  final String title;
  final String content;
  final String image;
  final String video;
  final String clinicId;
  final String specieId;
  final String postId;

  const AddPostParameters({
    required this.specieId,
    required this.clinicId,
    required this.video,
    required this.content,
    required this.title,
    required this.image,
    required this.postId,
  });

  @override
  List<Object> get props => [
        title,
        content,
        image,
        video,
        clinicId,
        specieId,
        postId,
      ];
}

class BlockUserClinicParameters extends Equatable {
  final String clinicId;
  final String userId;

  const BlockUserClinicParameters(this.clinicId,this.userId);

  @override
  List<Object> get props => [clinicId];
}