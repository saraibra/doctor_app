import 'package:doctor_app/main_feature/domain/entities/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  DoctorModel({
    required super.workingDays,
    required super.id,
    required super.name,
    required super.specialty,
    required super.bio,
    required super.phoneNumber,
    required super.email,
    required super.location,
    required super.imageUrl,
    required super.rating,
  });
  factory DoctorModel.fromJson(Map<dynamic, dynamic> json) {
    return DoctorModel(
      id: json['id']??'',
      name: json['name']?? '',
      specialty: json['specialty']?? '',
      phoneNumber: json['phoneNumber']?? '',
      imageUrl: json['image'],
      email: json['email']?? '',
      bio: json['bio']?? '',
      rating: json['rating'] != null
          ? double.parse(json['rating'].toString())
          : 0.0,
      location: LocationModel.fromJson(json['location'] ?? {}),
      workingDays:  (json['workingDays'] as List?)
          ?.map((x) => WorkingDaysModel.fromJson(x))
          .toList() ??
          [],
    );
  }
}

class LocationModel extends Location {
  LocationModel({
    required super.latitude,
    required super.longitude,
    super.address,
  });

  factory LocationModel.fromJson(Map<dynamic, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }
}



class WorkingDaysModel extends WorkingDays {
  WorkingDaysModel({
    required super.day,
    required super.dateTime,
    required super.appointments,
    required super.dayId,
  });

  factory WorkingDaysModel.fromJson(Map<dynamic, dynamic> json) {
    return WorkingDaysModel(
      dayId: json['dayId']?? 0,
      day: json['day']?? '',
      dateTime: DateTime.parse(json['dateTime'])?? DateTime.now(),
      appointments: json['appointments'].values
          .map((x) => AppointmentsModel.fromJson(x))
          .toList(),

    );
  }
}

class AppointmentsModel extends Appointments {
  const AppointmentsModel({
    required super.appointmentId,
    required super.startTime,
    required super.endTime,
    required super.booked,
  });

  factory AppointmentsModel.fromJson(Map<dynamic, dynamic> json) {
    return AppointmentsModel(
      appointmentId: json['appointmentId'].toString()?? '',
      startTime: json['startTime']?? '',
      endTime: json['endTime']?? '',
      booked: bool.parse(json['booked'].toString()),
    );
  }
}
