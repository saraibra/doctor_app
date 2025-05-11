import 'package:dartz/dartz.dart';
import 'package:doctor_app/main_feature/domain/entities/doctor_entity.dart';
import 'package:doctor_app/main_feature/domain/repositories/main_repository.dart';

import '../../../../core/errors/failure.dart';

class BookAppointmentUsecase {
  final MainRepository reporsitory;
  BookAppointmentUsecase(this.reporsitory);
  Future<Either<Failure, Unit>> call({
    required DoctorEntity doctor,
    required String userId,
    required DateTime date,
    required int workingDayId,
    required String appointmentId,
    required String time,
  }) async {
    return await reporsitory.bookAppointment(
      doctor: doctor,
      userId: userId,
      date: date,
      time: time,
      workingDayId: workingDayId,
      appointmentId: appointmentId,
    );
  }
}
