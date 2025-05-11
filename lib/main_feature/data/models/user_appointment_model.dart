import '../../domain/entities/user_appointment.dart';

class UserAppointmentModel extends UserAppointment {
  const UserAppointmentModel({
    required super.isBooked,
    required super.doctorName,
    required super.doctorSpecialty,
    required super.doctorImageUrl,
    required super.time,
    required super.userId,
    required super.doctorId,
    required super.date, required super.appointmentId, required super.isCanceled,
  });

  factory UserAppointmentModel.fromJson(Map<String, dynamic> json) {
    return UserAppointmentModel(
      doctorId: json['doctor_id'] as String,
      userId: json['user_id'] as String,
      doctorImageUrl: json['doctor_image'] as String,
      doctorName: json['doctor_name'] as String,
      doctorSpecialty: json['doctor_specialty'] as String,
      time: json['time'] as String,
      date: DateTime.parse(json['date'] as String),
      isBooked: json['is_booked'],
      isCanceled: json['is_canceled'] as bool,
      appointmentId:json['appointment_id'] as String,
    );
  }
}
