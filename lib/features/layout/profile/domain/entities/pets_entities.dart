import 'dart:io';

import 'package:equatable/equatable.dart';

class PetsEntities extends Equatable {
  final dynamic status;
  final dynamic message;
  final PetsData data;

  const PetsEntities({
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

class PetsData extends Equatable {
  final Breed breed;

  const PetsData({
    required this.breed,
  });

  @override
  List<Object> get props => [
        breed,
      ];
}

class Breed extends Equatable {
  final String petName;
  final int gender;
  final int species;
  final String breedId;
  final String birthdate;
  final File image;
  final String imageName;
  final String ownerToken;

  const Breed({
    required this.petName,
    required this.gender,
    required this.species,
    required this.breedId,
    required this.birthdate,
    required this.image,
    required this.ownerToken,
    required this.imageName,
  });

  @override
  List<Object> get props => [
        petName,
        gender,
        species,
        breedId,
        birthdate,
        image,
        ownerToken,
        imageName,
      ];
}

class BreedId extends Equatable {
  final bool status;
  final String message;
  final String data;

  const BreedId({
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

