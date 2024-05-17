import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart';

import '../entities/user-entity.dart';

abstract class UserRepository {
  Future<Either<Failure, LoginResponse>> registerUser({required UserEntity user});

  Future<Either<Failure,LoginResponse>> loginUser({required String email, required String password});

   Future<Either<Failure, bool>> generateOTP({required String number});
    Future<Either<Failure, bool>> verifyOTP({required String OTPcode, required String number});
}
