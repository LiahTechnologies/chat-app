import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:njadia/src/features/authentication/data/data_sources/user-data-source.dart';
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart';

import 'package:http/http.dart' as http;
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';

import '../../../../helper/mock-helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late UserRemoteDataSourceImpl userRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    userRemoteDataSourceImpl = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  final test_email = "cliffbetrand.sakwe@ubuea.cm";
  final test_password = "123456";

  final loginResponse = LoginResponse(
      token: "jdaklajlkdjlkjou1080e9 se90e901nscnsln8sa0nssnlsj97w0w");

  final token = "jdaklajlkdjlkjou1080e9 se90e901nscnsln8sa0nssnlsj97w0w";

  group('User remote dataaource testing', () {
    test('user remote implementation', () async {
      //  arrange
      when(mockHttpClient.post(Uri.parse("http://192.168.196.98:8000/login/"),
              body: {"email": test_email, "password": test_password}))
          .thenAnswer((_) async => http.Response(token, 200));

      // act

      // final result = await userRemoteDataSourceImpl.loginUser(
      //     email: test_email, password: test_password);

      // assert

      // expect(result, equals(token));
    });

    final path = "assets/images/Njangi Icon.png";

    final testUser = UserEntity(
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        password: "password",
        dob: "dob",
        tel: "tel",
        selfie: File(path),
        docs: File(path));
    test('Signup  testing ', () async {

      // arragnge
      when(mockHttpClient.post(Uri.parse("http://192.168.196.98:8000/li/"),
              body: testUser))
          .thenAnswer((_) async =>http.Response(token, 200));


      // act
      final result = await userRemoteDataSourceImpl.createUser(testUser);

      // assert
      // expect(result, equals(token));
    },timeout: Timeout(Duration(minutes: 1)));
  });
}
