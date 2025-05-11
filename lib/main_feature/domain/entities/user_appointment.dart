import 'package:equatable/equatable.dart';

class UserAppointment extends Equatable {
  final String appointmentId;

  final String userId;

  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImageUrl;
  final DateTime date;
  final String time;
  final bool isBooked;
  final bool isCanceled;
  const UserAppointment({
    required this.isCanceled,
    required this.appointmentId,
    required this.isBooked,
    required this.userId,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImageUrl,
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [
    isBooked,
    userId,
    doctorId,
    doctorName,
    doctorSpecialty,
    doctorImageUrl,
    date,
    time,
  ];
}
