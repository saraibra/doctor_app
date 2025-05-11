import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetUserDataUseCase{
final AuthRepository reporsitory;
  GetUserDataUseCase(this.reporsitory);
  Future<Either<Failure, User>> call({required String uid}) async {
    return await reporsitory.getUserData(uid: uid);
  }
}
