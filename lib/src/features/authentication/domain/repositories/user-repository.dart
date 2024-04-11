import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';

import '../entities/user-entity.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> registerUser({required UserEntity user});

  Future<Either<Failure,Login>> loginUser({required String email, required String password});

   Future<Either<Failure, bool>> generateOTP({required String number});
    Future<Either<Failure, bool>> verifyOTP({required String OTPcode, required String number});
}
