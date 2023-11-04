import '../../../domain/entities/Appointments/update_appointments_entities.dart';

class CreateAppointmentsModel extends CreateAppointmentsEntities {
  const CreateAppointmentsModel({
    required super.appointmentsDate,
    required super.errors,
    required super.status,
  });
  factory CreateAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return CreateAppointmentsModel(
      appointmentsDate:json['data']==null?json['data']: AppointmentsDataModel.fromJson(json['data']),
      status: json['success'],
      errors: Map<String, List<dynamic>>.from(json['errors']),
    );
  }
}

class AppointmentsDataModel extends AppointmentsDate {
  const AppointmentsDataModel({required super.appointments});

  factory AppointmentsDataModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsDataModel(
      appointments: json['appointmentDto'] == null
          ? json['appointmentDto']
          : AppointmentsModel.fromJson(json['appointmentDto']),
    );
  }
}

class AppointmentsModel extends Appointments {
  const AppointmentsModel({
    required super.id,
    required super.petId,
    required super.doctorId,
    required super.availabilityId,
    required super.visitComment,
    required super.appointmentDate,
    required super.appointmentTime,
    required super.status,
    required super.pet,
    required super.doctor,
    required super.availability,
  });

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(
      id: json['id'],
      petId: json['petId'],
      doctorId: json['doctorId'],
      availabilityId: json['availabilityId'],
      visitComment: json['visitComment'],
      appointmentDate: json['appointmentDate'],
      appointmentTime: json['appointmentTime'],
      status: json['status'],
      pet: json['pet'] == null
          ? json['pet']
          : PetAppointmentsModel.fromJson(json['pet']),
      doctor: json['doctor'] == null
          ? json['doctor']
          : DoctorAppointmentsModel.fromJson(json['doctor']),
      availability: json['availability'] == null
          ? json['availability']
          : AvailabilityAppointmentsModel.fromJson(json['availability']),
    );
  }
}

class PetAppointmentsModel extends PetAppointments {
  const PetAppointmentsModel({
    required super.petName,
    required super.gender,
    required super.imageName,
    required super.birthdate,
  });
  factory PetAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return PetAppointmentsModel(
      petName: json['petName'],
      gender: json['gender'],
      imageName: json['imageName'],
      birthdate: json['birthdate'],
    );
  }
}

class DoctorAppointmentsModel extends DoctorAppointments {
  const DoctorAppointmentsModel({
    required super.fullName,
    required super.address,
    required super.imageName,
    required super.image,
  });
  factory DoctorAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return DoctorAppointmentsModel(
      fullName: json['fullName'],
      address: json['address'],
      imageName: json['imageName'],
      image: json['image'],
    );
  }
}

class AvailabilityAppointmentsModel extends AvailabilityAppointments {
  const AvailabilityAppointmentsModel({
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
  });

  factory AvailabilityAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityAppointmentsModel(
      endTime: json['endTime'],
      startTime: json['address'],
      dayOfWeek: json['dayOfWeek'],
    );
  }
}
