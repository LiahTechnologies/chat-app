import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/failures.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:njadia/src/features/authentication/domain/repositories/user-repository.dart';

class UserUsecase {
  UserRepository userRepository;
  UserUsecase({required this.userRepository});

  Future<Either<Failure, bool>> create(UserEntity user) {
    print("SIGNUP IN USECASE WAS CALLED SUCCESSFULLY");
    return userRepository.registerUser(user: user);
  }

  Future<Either<Failure, Login>> login(
      {required String email, required String password}) {
    print("LOG IN USECASE WAS CALLED SUCCESSFULLY");
    return userRepository.loginUser(email: email, password: password);
  }

  Future<Either<Failure, bool>> generateOTP({required String number}) {
    print("LOG IN USECASE WAS CALLED SUCCESSFULLY");
    return userRepository.generateOTP(number: number);
  }

  Future<Either<Failure, bool>> verifyOTP(
      {required String number, required String OTPCode}) {
    print("LOG IN USECASE WAS CALLED SUCCESSFULLY");
    return userRepository.verifyOTP(OTPcode: OTPCode, number: number);
  }
}
