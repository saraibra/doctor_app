import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository reporsitory;
  RegisterUseCase(this.reporsitory);
  Future<Either<Failure, Unit>> call(
      {required String email,
      required String password,
        required String phoneNumber,

        required String name}) async {
    return await reporsitory.registerUser(
      phoneNumber: phoneNumber,
        email: email, password: password, name: name);
  }
}
