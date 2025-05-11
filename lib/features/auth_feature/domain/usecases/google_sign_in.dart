import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';

class GoogleSigninUseCase{
 final AuthRepository reporsitory;
  GoogleSigninUseCase(this.reporsitory);
  Future<Either<Failure, Unit>> call() async {
    return await reporsitory.signInWithGoogle();
  }
}