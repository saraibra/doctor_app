//import '';

import '../../domain/entities/user_entity.dart' as UserData;

import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImp extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImp(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Unit>> emailSignIn(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        remoteDataSource.signInWithEmail(email: email, password: password);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
on FirebaseAuthException catch(e){
  return Left(WrongFailure(message: e.message!));
}

    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword({required String email}) async {
    if (await networkInfo.isConnected) {
      try {
        remoteDataSource.forgotPassword(email: email);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> registerUser(
      {required String email,
      required String password,
        required String phoneNumber,

        required String name}) async {
    if (await networkInfo.isConnected) {
      try {
        remoteDataSource.signUp(email: email, password: password, name: name,phoneNumber: phoneNumber);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }



  @override
  Future<Either<Failure, Unit>> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> signInWithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        remoteDataSource.signInWithGoogle();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserData.User>> getUserData({required String uid}) async {
    if (await networkInfo.isConnected) {
      try {
        UserModel user = await remoteDataSource.getUsersData(id: uid);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserData() {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    if (await networkInfo.isConnected) {
      try {
     await remoteDataSource.logout();
        return Future.value(const Right(unit));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
}}
