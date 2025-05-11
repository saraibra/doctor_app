import 'package:dartz/dartz.dart';
import 'package:doctor_app/main_feature/domain/entities/doctor_entity.dart';
import 'package:doctor_app/main_feature/domain/entities/user_appointment.dart';
import 'package:doctor_app/main_feature/domain/repositories/main_repository.dart';

import '../../../../core/errors/failure.dart';


class GetAllAppointmentsUsecase{
  final MainRepository reporsitory;
  GetAllAppointmentsUsecase(this.reporsitory);
  Future<Either<Failure, List<UserAppointment>>> call({required String userId}) async {
    return await reporsitory.getAllAppointments(userId: userId);
  }
}
