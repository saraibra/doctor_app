import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class UpdateUserDataUseCase{
final AuthRepository reporsitory;
  UpdateUserDataUseCase(this.reporsitory);
  Future<Either<Failure, Unit>> call({required User user}) async {
    return await reporsitory.updateUserData();
  }
}