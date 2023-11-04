import '../../domain/entites/vac/vaccination_entities.dart';

class VaccinationModel extends VaccinationEntities {
  const VaccinationModel({
    required super.vacName,
    required super.vacDate,
    required super.vacTime,
    required super.vacComment,
    required super.vacState,
    required super.petId,
    required super.vacId,
  });
  factory VaccinationModel.fromJson(Map<String, dynamic> json) {
    return VaccinationModel(
      vacName: json['vacName'],
      vacDate: json['vacDate'],
      vacTime: json['vacTime'],
      vacComment: json['vacComment'],
      vacState: json['vacState'],
      petId: json['petId'],
      vacId: json['vacId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vacName': vacName,
      'vacDate': vacDate,
      'vacTime': vacTime,
      'vacComment': vacComment,
      'vacState': vacState,
      'petId': petId,
      'vacId': vacId,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'vacName': vacName,
      'vacDate': vacDate,
      'vacTime': vacTime,
      'vacComment': vacComment,
      'vacState': vacState,
      'petId': petId,
      'vacId': vacId,
    };
  }
}

class VaccinationNameModel extends VaccinationNameEntities {
  const VaccinationNameModel({
    required super.vacName,
    required super.vacID,
  });

  factory VaccinationNameModel.fromJson(Map<String, dynamic> json) {
    return VaccinationNameModel(
      vacName: json['vacName'],
      vacID: json['vacID'],
    );
  }
}
