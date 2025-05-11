import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';

class FacebookLoginUseCase{
 final AuthRepository reporsitory;
  FacebookLoginUseCase(this.reporsitory);
  Future<Either<Failure, Unit>> call() async {
    return await reporsitory.signInWithFacebook();
  }
}