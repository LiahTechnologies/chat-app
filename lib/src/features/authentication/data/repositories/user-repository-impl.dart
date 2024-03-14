import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/failures.dart';
import 'package:njadia/src/features/authentication/data/data_sources/user-data-source.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:njadia/src/features/authentication/domain/repositories/user-repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserDataSourceImpl userDataSourceImpl;

  UserRepositoryImpl({required this.userDataSourceImpl});

  @override
  Future loginUser({required String email, required String password}) =>
      userDataSourceImpl.loginUser(email: email, password: password);



  @override
  Future<Either<Failure, bool>> registerUser({required UserEntity user}) =>
      userDataSourceImpl.createUser(user);
}
