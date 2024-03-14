import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/failures.dart';
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:http/http.dart' as http;

import '../../../../common/urls.dart';

abstract class UserDataSource {
  Future<Either<ServerFailure, bool>> createUser(UserEntity user);
  Future<Either<ServerFailure, bool>> loginUser(
      {required email, required password});
}

class UserDataSourceImpl extends UserDataSource {
  final http.Client client;

  UserDataSourceImpl({required this.client});

  @override
  Future<Either<ServerFailure, bool>> createUser(UserEntity user)async {
         var length = await user.selfie.length;

      
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(AppUrls.signup_file),
    );

    var multipartFile = await http.MultipartFile.fromPath("selfie", user.selfie.path);
    var multipartFileDocs =
        await http.MultipartFile.fromPath("docs", user.docs.path);

    request.files.add(multipartFile);
    request.files.add(multipartFileDocs);

    var endpointResponse = await request.send();

    var response = await http.Response.fromStream(endpointResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (endpointResponse.statusCode == 200) {
      print("FILE UPLOADED ${result['selfie'].toString()}");
      final data = {
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email,
        "password": user.password,
        "tel": user.tel,
        "dob": user.dob,
        "selfie": result['selfie'],
        "docs": result['docs']
      };

      

      final response = await http.post(Uri.parse(AppUrls.signup_details),
          body: json.encode(data),
          headers: {"Content-Type": "Application/json"});
      if (response.statusCode == 200)
         return  Right(true);
      else
        return Right(false);
    } else
      return Left(ServerFailure("User was not created"));
  }




  @override
  Future<Either<ServerFailure, bool>> loginUser(
      {required email, required password}) async{
   
        final response = await client.post(Uri.parse(AppUrls.login),
        body: json.encode({"email": email, "password": password}),
        headers: {"Content-Type": "Application/json"});

    if (response.statusCode == 200) 
      return Right(true);
   else 
      return Left(ServerFailure("Server error"));
    
  }
}
