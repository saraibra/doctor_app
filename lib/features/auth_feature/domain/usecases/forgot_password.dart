import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository reporsitory;
  ForgotPasswordUseCase(this.reporsitory);
  Future<Either<Failure, Unit>> call({required String email}) async {
    return await reporsitory.forgotPassword(email: email);
  }
}
