import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart';
import 'package:njadia/src/features/authentication/data/repositories/user-repository-impl.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import '../../../../helper/mock-helper.mocks.dart';

import 'package:http/http.dart' as http;

void main() {
  late UserRepositoryImpl userRepositoryImpl;

  late MockUserRemoteDataSource mockUserRemoteDataSource;
  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    userRepositoryImpl =
        UserRepositoryImpl(userRemoteDataSource: mockUserRemoteDataSource);
  });

  final test_email = "cliff@gmail.com";
  final test_password = "123456";

  final loginResponse =
      LoginResponse(token: "oqoiuw slkxcops lj opiweu nxcxnoioweu ios n");

  final path = "";

  final testUser = UserEntity(
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
      password: "password",
      dob: "dob",
      tel: "tel",
      selfie: File(path),
      docs: File(path));

  test('is User logged in', () async {
    // arrange

    when(mockUserRemoteDataSource.loginUser(
            email: test_email, password: test_password))
        .thenAnswer((realInvocation) async => Future.value(loginResponse));

    // act

    final result = await userRepositoryImpl.loginUser(
        email: test_email, password: test_password);
    // assert

    expect(result, equals(Right(loginResponse)));
  });

  test('check if signup repository implementation is working', () async {
    //  arrange
    when(mockUserRemoteDataSource.createUser(testUser))
        .thenAnswer((realInvocation) async => Future.value(true));

    // act

    final result = await userRepositoryImpl.registerUser(user: testUser);

    // assert

    expect(result, equals(Right(true)));
  });
}
