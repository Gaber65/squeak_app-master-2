import 'package:equatable/equatable.dart';

class DeleteAvailabilitiesEntities extends Equatable {
  const DeleteAvailabilitiesEntities({
    required this.data,
  });

  final DeleteData data;

  @override
  List<Object> get props => [data];
}

class DeleteData extends Equatable {
  const DeleteData();

  @override
  List<Object> get props => [];
}