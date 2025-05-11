import 'package:dartz/dartz.dart';
import 'package:doctor_app/main_feature/domain/entities/doctor_entity.dart';
import 'package:doctor_app/main_feature/domain/repositories/main_repository.dart';

import '../../../../core/errors/failure.dart';


class CancelAppointmentUsecase{
  final MainRepository reporsitory;
  CancelAppointmentUsecase(this.reporsitory);
  Future<Either<Failure, Unit>> call({
    required String appointmentId,
    required String doctor,
    required DateTime date,
    required String time,
    required int workingDayId,
    required String appointmentIndex,
    required String doctorName,
    required String doctorSpecialty,
    required String doctorImageUrl,
 }) async {
    return await reporsitory.cancelAppointment(appointmentId: appointmentId,
      doctor: doctor,
      date: date,
      time: time,
      workingDayId: workingDayId,
      appointmentIndex: appointmentIndex,
      doctorName: doctorName,
      doctorSpecialty: doctorSpecialty,
      doctorImageUrl: doctorImageUrl,
    );
  }
}
