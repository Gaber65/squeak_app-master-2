import 'package:equatable/equatable.dart';

import 'create_availabilities_entities.dart';

class GetAvailabilitiesEntities extends Equatable {
  final GetAvailabilitiesDate availabilitiesDate;

  const GetAvailabilitiesEntities({
    required this.availabilitiesDate,
  });

  @override
  List<Object> get props => [
        availabilitiesDate,
      ];
}

class GetAvailabilitiesDate extends Equatable {
  const GetAvailabilitiesDate({
    required this.count,
    required this.availabilities,
  });

  final int count;
  final List<Availabilities> availabilities;

  @override
  List<Object> get props => [
        count,
        availabilities,
      ];
}
