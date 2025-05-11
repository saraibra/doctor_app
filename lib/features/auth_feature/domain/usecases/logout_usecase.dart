import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase{
  final AuthRepository reporsitory;
  LogoutUseCase(this.reporsitory);
  Future<Either<Failure, Unit>> call() async {
    return await reporsitory.logout();
  }
}