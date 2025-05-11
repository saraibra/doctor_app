import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String id;
  final String name;
  final String specialty;
  final String phoneNumber;
  final String email;
  final String bio;
  final double? rating;
   String? imageUrl;

  final Location location;
  final List<WorkingDays> workingDays;
   DoctorEntity({required this.rating,
    required this.workingDays,
    required this.id,
    required this.name,
  this.imageUrl,

  required this.specialty,
    required this.bio,
    required this.phoneNumber,
    required this.email,
    required this.location,
  }
);

  @override
  List<Object?> get props => [
    id,
    name,
    specialty,
    phoneNumber,
    email,
    workingDays,
  ];
}


class WorkingDays extends Equatable {
  final String day;
  final int dayId;
  List<dynamic>? appointments;

  final DateTime dateTime;

  WorkingDays({required this.dayId, required this.day, required this.dateTime, required this.appointments});

  @override
  List<Object?> get props => [day, dateTime, appointments, dayId];
}

class Appointments extends Equatable {
  final String appointmentId;
  final String startTime;
  final String endTime;
  final bool booked;
  const Appointments({
    required this.appointmentId,
    required this.startTime,
    required this.endTime,
    required this.booked,
  });

  @override
  List<Object?> get props => [startTime, endTime, booked,appointmentId];
}

class Location extends Equatable {
  String? address;
  double? latitude;
  double? longitude;

  Location({this.address, this.latitude, this.longitude});

  @override
  List<Object?> get props => [address, latitude, longitude];
}
