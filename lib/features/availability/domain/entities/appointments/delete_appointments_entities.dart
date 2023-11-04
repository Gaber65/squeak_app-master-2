import 'package:equatable/equatable.dart';

class DeleteAppointmentsEntities extends Equatable {
  const DeleteAppointmentsEntities({
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