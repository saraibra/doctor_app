import 'package:dartz/dartz.dart';
import 'package:doctor_app/core/errors/failure.dart';
import 'package:doctor_app/main_feature/data/models/doctor_model.dart';
import 'package:doctor_app/main_feature/domain/entities/doctor_entity.dart';
import 'package:doctor_app/main_feature/domain/entities/user_appointment.dart';
import 'package:doctor_app/main_feature/domain/repositories/main_repository.dart';

import '../../../core/errors/exception.dart';
import '../../../core/network/network_info.dart';
import '../datasource/remote_datasource.dart';

class MainRepositoryImp extends MainRepository {
  final MainRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MainRepositoryImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    if (await networkInfo.isConnected) {
      try {
        final doctors = await remoteDataSource.getAllDoctors();
        return Right(doctors);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> bookAppointment({
    required DoctorEntity doctor,
    required String userId,
    required DateTime date,
    required String time,
    required int workingDayId,
    required String appointmentId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final doctors = await remoteDataSource.bookAppointment(
          doctor: doctor as DoctorModel,
          userId: userId,
          date: date,
          time: time,
          workingDayId: workingDayId,
          appointmentIndex: appointmentId,
        );
        return Right(doctors);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserAppointment>>> getAllAppointments({
    required String userId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final appointments = await remoteDataSource.getAllAppointments(
          userId: userId,
        );
        return Right(appointments);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
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
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.cancelAppointment(
          appointmentId: appointmentId,
          date: date,
          doctorId: doctor ,
          time: time,
          workingDayId: workingDayId,
          appointmentIndex: appointmentIndex,
          doctorName:doctorName,
          doctorSpecialty: doctorSpecialty,
          doctorImageUrl: doctorImageUrl,
        );
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
