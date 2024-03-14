import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/failures.dart';

import '../entities/user-entity.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> registerUser({required UserEntity user});

  Future loginUser({required String email, required String password});
}
