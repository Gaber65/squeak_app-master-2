import 'dart:io';

import 'package:equatable/equatable.dart';

class OwnerPetsEntities extends Equatable {
  final dynamic status;
  final dynamic message;
  final OwnerPetsData data;

  const OwnerPetsEntities({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object> get props => [
        status,
        message,
        data,
      ];
}

class OwnerPetsData extends Equatable {
  final List<OwnerBreed> breed;

  const OwnerPetsData({
    required this.breed,
  });

  @override
  List<Object> get props => [
        breed,
      ];
}

class OwnerBreed extends Equatable {
  final String petName;
  final String petId;
  final int gender;
  final int species;
  final String breedId;
  final String birthdate;
  final dynamic image;
  final dynamic imageName;
  final String breedName;

  const OwnerBreed(
      {required this.petName,
      required this.gender,
      required this.species,
      required this.breedId,
      required this.birthdate,
      required this.image,
      required this.imageName,
      required this.breedName,
      required this.petId});

  @override
  List<Object> get props => [
        petName,
        gender,
        species,
        breedId,
        birthdate,
        image,
        imageName,
      ];
}
