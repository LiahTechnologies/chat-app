import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/failures.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:njadia/src/features/authentication/domain/repositories/user-repository.dart';

class UserUsecase {
  UserRepository userRepository;
  UserUsecase({required this.userRepository});

  Future<Either<Failure, bool>> execute(UserEntity user) {
    return userRepository.registerUser(user: user);
  }


  Future login({required String email, required String password}) {
    return userRepository.loginUser(email: email, password: password);
  }
}
