import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:njadia/src/features/authentication/domain/usecases/user-usecase.dart';
import '../../../../helper/mock-helper.mocks.dart';

void main() {
  late UserUsecase usecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UserUsecase(userRepository: mockUserRepository);
  });

  final test_token =
      Login(token: "48204804ljsdl000000mcsu09sd89nskjsakljas0980s");
  final test_emai = 'cliffbetrand.sakwe@ubuea.cm';
  final test_password = '123456';

  test('Is User logined', () async {
    // arrange
    when(mockUserRepository.loginUser(
            email: test_emai, password: test_password))
        .thenAnswer((_) async => Right(test_token));

    //act

    final result =
        await usecase.login(email: test_emai, password: test_password);

    // assert

    expect(result, equals(Right(test_token)));
  });

// Singup  priliminary data

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
  test('Is user Signup', () async {
    // arrange
    when(mockUserRepository.registerUser(user: testUser))
        .thenAnswer((_) async => Right(true));

    // act

    final result = await usecase.create(testUser);

    // assert

    expect(result, equals(Right(true)));
  });
}
