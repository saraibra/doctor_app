import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> registerUser({required String email,required String password,required String name,        required String phoneNumber,
  });
  Future<Either<Failure, Unit>> emailSignIn({required String email,required String password});
  Future<Either<Failure, Unit>> signInWithGoogle();
  Future<Either<Failure, Unit>> signInWithFacebook();
  Future<Either<Failure, Unit>> forgotPassword({required String email});
  Future<Either<Failure, Unit>> updateUserData();
    Future<Either<Failure, User>> getUserData({required String uid});
  Future<Either<Failure, Unit>> logout();


}
