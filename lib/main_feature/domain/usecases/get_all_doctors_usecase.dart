import 'package:dartz/dartz.dart';
import 'package:doctor_app/main_feature/domain/entities/doctor_entity.dart';
import 'package:doctor_app/main_feature/domain/repositories/main_repository.dart';

import '../../../../core/errors/failure.dart';


class GetAllDoctorsUsecase{
  final MainRepository reporsitory;
  GetAllDoctorsUsecase(this.reporsitory);
Future<Either<Failure, List<DoctorEntity>>> call() async {
    return await reporsitory.getAllDoctors();
  }
}
