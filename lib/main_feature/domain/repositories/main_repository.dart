import 'package:doctor_app/main_feature/domain/entities/doctor_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_app/main_feature/domain/entities/user_appointment.dart';

import '../../../core/errors/failure.dart';

abstract class MainRepository {
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors();
  Future<Either<Failure, Unit>> bookAppointment({
    required DoctorEntity doctor,
    required String userId,
    required DateTime date,
    required String time,
    required int workingDayId,
    required String appointmentId,
  });
  Future<Either<Failure, Unit>> cancelAppointment({
    required String appointmentId,
    required String doctor,
    required DateTime date,
    required String time,
    required int workingDayId,
    required String appointmentIndex,
    required String doctorName,
    required String doctorSpecialty,
    required String doctorImageUrl,
  });
  Future<Either<Failure, List<UserAppointment>>> getAllAppointments({
    required String userId,
  });
}