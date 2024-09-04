import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';

import '../../../../core/common/errors/failures.dart';
import 'package:http/http.dart' as http;

import '../../../../core/common/helper_function.dart';
import '../../../../core/common/urls.dart';

abstract class ChangeProfileRemoteDatasource{


    Future<Either<Failure, bool>> changeProfilePic({required File picture, required String uid});
 
}

 class ChangeProfileRemoteDatasourceImpl extends ChangeProfileRemoteDatasource{
final http.Client client;
  
 ChangeProfileRemoteDatasourceImpl({required this.client});

  @override
  Future<Either<Failure, bool>> changeProfilePic({required File picture, required String uid}) async{
    try {
      
          var request = http.MultipartRequest(
      "POST",
      Uri.parse(AppUrls.uploadSignupFile),
    );

   
    var multipartProfile =
        await http.MultipartFile.fromPath("profilePi", picture.path);

 
    request.files.add(multipartProfile);
    request.fields.addAll({"folder":"profile"});

    var endpointResponse = await request.send();

    var response = await http.Response.fromStream(endpointResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if(endpointResponse.statusCode==200){
      final data ={
        "uid":uid,
        "profilePic":result["file"]
      };
       final response = await http.post(Uri.parse(AppUrls.signup),
          body: json.encode(data),
          headers: {"Content-Type": "Application/json"});

      if (response.statusCode == 201) {
        
     final result = jsonDecode(response.body) as Map<String, dynamic>;
      await HelperFunction.saveUserProfilePic(result['profilePci']);

        return Right(true);
      } else
        return   Left(ServerFailure(""));
    }
    return Left(ServerFailure("file not uploaded"));


    } on ServerExceptions {
      throw Left(ServerFailure("Error"));
    }
  }

 }
