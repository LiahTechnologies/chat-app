// Mocks generated by Mockito 5.4.4 from annotations
// in njadia/test/src/helper/mock-helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:convert' as _i10;
import 'dart:typed_data' as _i12;

import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i11;
import 'package:njadia/src/core/common/errors/failures.dart' as _i7;
import 'package:njadia/src/features/authentication/data/data_sources/user-data-source.dart'
    as _i9;
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart'
    as _i3;
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart'
    as _i8;
import 'package:njadia/src/features/authentication/domain/repositories/user-repository.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLoginResponse_1 extends _i1.SmartFake implements _i3.LoginResponse {
  _FakeLoginResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_3 extends _i1.SmartFake
    implements _i4.StreamedResponse {
  _FakeStreamedResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i5.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i3.LoginResponse>> registerUser(
          {required _i8.UserEntity? user}) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerUser,
          [],
          {#user: user},
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i3.LoginResponse>>.value(
                _FakeEither_0<_i7.Failure, _i3.LoginResponse>(
          this,
          Invocation.method(
            #registerUser,
            [],
            {#user: user},
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i3.LoginResponse>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i3.LoginResponse>> loginUser({
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginUser,
          [],
          {
            #email: email,
            #password: password,
          },
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i3.LoginResponse>>.value(
                _FakeEither_0<_i7.Failure, _i3.LoginResponse>(
          this,
          Invocation.method(
            #loginUser,
            [],
            {
              #email: email,
              #password: password,
            },
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i3.LoginResponse>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> generateOTP(
          {required String? number}) =>
      (super.noSuchMethod(
        Invocation.method(
          #generateOTP,
          [],
          {#number: number},
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, bool>>.value(
            _FakeEither_0<_i7.Failure, bool>(
          this,
          Invocation.method(
            #generateOTP,
            [],
            {#number: number},
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, bool>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> verifyOTP({
    required String? OTPcode,
    required String? number,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #verifyOTP,
          [],
          {
            #OTPcode: OTPcode,
            #number: number,
          },
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, bool>>.value(
            _FakeEither_0<_i7.Failure, bool>(
          this,
          Invocation.method(
            #verifyOTP,
            [],
            {
              #OTPcode: OTPcode,
              #number: number,
            },
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, bool>>);
}

/// A class which mocks [UserRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRemoteDataSource extends _i1.Mock
    implements _i9.UserRemoteDataSource {
  MockUserRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i3.LoginResponse>> createUser(
          _i8.UserEntity? user) =>
      (super.noSuchMethod(
        Invocation.method(
          #createUser,
          [user],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i3.LoginResponse>>.value(
                _FakeEither_0<_i7.Failure, _i3.LoginResponse>(
          this,
          Invocation.method(
            #createUser,
            [user],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i3.LoginResponse>>);

  @override
  _i6.Future<_i3.LoginResponse> loginUser({
    required dynamic email,
    required dynamic password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginUser,
          [],
          {
            #email: email,
            #password: password,
          },
        ),
        returnValue: _i6.Future<_i3.LoginResponse>.value(_FakeLoginResponse_1(
          this,
          Invocation.method(
            #loginUser,
            [],
            {
              #email: email,
              #password: password,
            },
          ),
        )),
      ) as _i6.Future<_i3.LoginResponse>);

  @override
  _i6.Future<bool> generateOTP({required String? number}) =>
      (super.noSuchMethod(
        Invocation.method(
          #generateOTP,
          [],
          {#number: number},
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> verifyOTP({
    required String? number,
    required String? OTPCode,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #verifyOTP,
          [],
          {
            #number: number,
            #OTPCode: OTPCode,
          },
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i10.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i10.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i10.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i10.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<String>.value(_i11.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<String>);

  @override
  _i6.Future<_i12.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i12.Uint8List>.value(_i12.Uint8List(0)),
      ) as _i6.Future<_i12.Uint8List>);

  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i6.Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i6.Future<_i4.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
