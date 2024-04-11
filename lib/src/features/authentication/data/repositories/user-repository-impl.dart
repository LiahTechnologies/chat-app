
import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/authentication/data/data_sources/user-data-source.dart';
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:njadia/src/features/authentication/domain/repositories/user-repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, LoginResponse>> loginUser(
      {required String email, required String password}) async {
    print("loging IMPLEMENTATION REPOSITORY CALLED");
    try {
      final response = await userRemoteDataSource.loginUser(
          email: email, password: password);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure("Counld not connect to server"));
    }
  }

  @override
  Future<Either<Failure, bool>> registerUser({required UserEntity user}) async {
    try {
      final response = await userRemoteDataSource.createUser(user);
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("Something happened while creating a user");
    }
  }

  @override
  Future<Either<Failure, bool>> generateOTP({required String number}) async {
    try {
      final response = await userRemoteDataSource.generateOTP(number: number);
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("Something happened while creating a user");
    }
  }
  
  @override
  Future<Either<Failure, bool>> verifyOTP({required String OTPcode, required String number})async {
    try {
      final response = await userRemoteDataSource.verifyOTP(number: number,OTPCode: OTPcode);
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("Something happened while creating a user");
    }
  }
}
