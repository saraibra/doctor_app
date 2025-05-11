import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';

class EmailLoginUseCase{
final AuthRepository reporsitory;
  EmailLoginUseCase(this.reporsitory);
  Future<Either<Failure, Unit>> call({required String email,required String password}) async {
    return await reporsitory.emailSignIn(email: email,password: password);
  }
}
