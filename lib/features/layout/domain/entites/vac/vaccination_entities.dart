import 'package:equatable/equatable.dart';

class VaccinationEntities extends Equatable {
  final String vacName;
  final String vacDate;
  final String vacTime;
  final String vacComment;
  final String petId;
  final String vacId;
  final bool vacState;

  const VaccinationEntities({
    required this.vacName,
    required this.vacDate,
    required this.vacTime,
    required this.vacComment,
    required this.vacState,
    required this.petId,
    required this.vacId,
  });

  @override
  List<Object> get props =>
      [vacDate, vacTime, vacComment, petId, vacState, vacName, vacId];
}

class VaccinationNameEntities extends Equatable {
  final String vacName;
  final String vacID;

  const VaccinationNameEntities({
    required this.vacName,
    required this.vacID,
  });

  @override
  List<Object> get props => [vacName, vacID];
}
