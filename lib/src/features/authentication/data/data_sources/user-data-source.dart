import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../../core/common/urls.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failure,LoginResponse>> createUser(UserEntity user,File selfie, File docs, File profilePic);
  Future<LoginResponse> loginUser({required email, required password});
  Future<bool> generateOTP({required String number});
  Future<bool> verifyOTP({required String number, required String OTPCode});
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure,LoginResponse>> createUser(UserEntity user, File selfie, File docs, File profilePic) async {


//  Directory tempDir = await getTemporaryDirectory();
//       var cookieJar = PersistCookieJar(
//         storage: FileStorage(tempDir.path),
//       );
 
    // final data = {
    //   "firstName": user.firstName,
    //   "lastName": user.lastName,
    //   "email": user.email,
    //   "password": user.password,
    //   "tel": user.tel,
    //   "dob": user.dob,
    //   "selfie":"Selfie",
    //   "docs":"docs"
    // };

    // print("SIGNUP PATH ${AppUrls.signup}");
    // final response = await http.post(Uri.parse(AppUrls.signup),
    //     body: json.encode(data), headers: {"Content-Type": "Application/json"});
    
       // Save the cookies from the response
      // var cookies = response.headers['set-cookie'];
      // if (cookies != null) {
      //   cookieJar.saveFromResponse(Uri.parse(AppUrls.signup), [Cookie.fromSetCookieValue(cookies)]);
      // }

    // if (response.statusCode == 201){
    //    final userData =
    //     await LoginResponse.fromjson(json.decode(response.body));
    //     await HelperFunction.saveUserEmail(userData.userEmail);
        // await HelperFunction.saveUserName(" ${userData.firstName} ${userData.lastName}");
    //     await HelperFunction.saveUserID(userData.uid);
    //     await HelperFunction.saveUserTel(userData.tel);
    //     await HelperFunction.saveUserProfile(userData.lastName);
    //     await HelperFunction.saveUserLoggInState(true);
    //     // print("THIS IS THE USER DATA: $userData");

    //     return Right(userData);
    // }

    // if(response.statusCode==409)
    //   return Left(ServerFailure("Email already exist"));
     
    // else
    //   throw Left(ServerFailure("User was not created"));
  



    // var length = await user.selfie.length;

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(AppUrls.uploadSignupFile),
    );

    var multipartFile =
        await http.MultipartFile.fromPath("selfie", selfie.path);
    var multipartFileDocs =
        await http.MultipartFile.fromPath("docs", docs.path);
    var multipartProfile =
        await http.MultipartFile.fromPath("profilePic", profilePic.path);

    request.files.add(multipartFile);
    request.files.add(multipartFileDocs);
    request.files.add(multipartProfile);
    request.fields.addAll({"folder":"signup"});

    var endpointResponse = await request.send();

    var response = await http.Response.fromStream(endpointResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    print("THIS IS THE RESPONSE FROM $result");

    if (endpointResponse.statusCode >= 200) {
      print("FILE UPLOADED ${result['selfie'].toString()}");
      final data = {
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email,
        "password": user.password,
        "tel": user.tel,
        "dob": user.dob,
        "selfie": result['selfie'],
        "docs": result['docs'],
        "profilePic":result['profilePic']
      };

      final response = await http.post(Uri.parse(AppUrls.signup),
          body: json.encode(data),
          headers: {"Content-Type": "Application/json"});

      if (response.statusCode == 201) {
        final userData =
        await LoginResponse.fromjson(json.decode(response.body));
      await HelperFunction.saveUserEmail(userData.userEmail);
      await HelperFunction.saveUserName("${userData.firstName} ${userData.lastName} ");
      await HelperFunction.saveUserID(userData.uid);
      await HelperFunction.saveUserTel(userData.tel);
      await HelperFunction.saveUserProfilePic(userData.profilePic);
      await HelperFunction.saveUserProfile(userData.lastName);
      await HelperFunction.saveUserLoggInState(true);

        return Right(userData);
      } else
        throw ServerExceptions();
    } else
      throw ServerFailure("User was not created");


      
  }

  @override
  Future<LoginResponse> loginUser({required email, required password}) async {

      //  Directory tempDir = await getTemporaryDirectory();
      // var cookieJar = PersistCookieJar(
      //   storage: FileStorage(tempDir.path),
      // );
 
    print("LOGIN PATH ${AppUrls.login}");
    final response = await client.post(Uri.parse(AppUrls.login),
        body: json.encode({"email": email, "password": password}),
        headers: {"Content-Type": "Application/json"});

          // Save the cookies from the response
      // var cookies = response.headers['set-cookie'];
      // if (cookies != null) {
      //   // cookieJar.saveFromResponse(Uri.parse(AppUrls.signup), [Cookie.fromSetCookieValue(cookies)]);
      // }


    if (response.statusCode == 200) {

      final userData = LoginResponse.fromjson(json.decode(response.body));
      print("USER LOGING DATA ${userData.firstName}");
      await HelperFunction.saveUserEmail(userData.userEmail);
      await HelperFunction.saveUserName("${userData.firstName} ${userData.lastName} ");
      await HelperFunction.saveUserID(userData.uid);
      await HelperFunction.saveUserTel(userData.tel);
      await HelperFunction.saveUserProfilePic(userData.profilePic);
      await HelperFunction.saveUserProfile(userData.lastName);
      await HelperFunction.saveUserLoggInState(true);

      return userData;
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<bool> generateOTP({required String number}) async {
    final response = await http.post(Uri.parse(AppUrls.OTP),
        body: json.encode({"number": number}),
        headers: {"content-Type": "Application/json"});
    if (response.statusCode == 200) {
      print("OTP CODE IS WORKING");
      return true;
    } else {
      print("OTP VERIFICATION CODE NOT GENERATED");
      return false;
    }





  }

  @override
  Future<bool> verifyOTP(
      {required String number, required String OTPCode}) async {
    final response = await http.post(Uri.parse(AppUrls.OTP_VERIFICATION),
        body: json.encode({"number": number, "code": OTPCode}),
        headers: {"Content-Type": "Application/json"});

    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
