

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';

import '../../../../core/common/errors/failures.dart';
import 'package:http/http.dart' as http;

import '../../../../core/common/urls.dart';

abstract class BallotRemoteDataSource{

  Future< bool> generateBallots({required String groupId});
  Future< List<String>> fetchBallots({required String groupId,required String uid});

}


class BallotRemoteDataSourceImpl extends BallotRemoteDataSource{

  final  http.Client client;

  BallotRemoteDataSourceImpl({required this.client});




  @override
  Future< List<String>> fetchBallots({required String groupId, required String uid}) async {
    try {
       final data = {
        "groupId":groupId,
        "uid":uid
      };

      print("THIS BALLOT FUNCTION IS BEING CALLED");

      final result = await client.post(Uri.parse(AppUrls.fetchBallots),body: json.encode(data),headers: {"content-type":"application/json"});
        Iterable json_data =json.decode(result.body);
        List<String> ballots = List<String>.from(json_data);
        return  ballots;

    } on ServerExceptions {
      throw ServerFailure("");
    }
  }




  @override
  Future< bool> generateBallots({required String groupId})async {
     try {
      final response = await client.post(Uri.parse(AppUrls.ballots),body: json.encode({"groupId":groupId}),headers: {"content-type":"application/json"});
      if (response.statusCode==200)
           return true;
      else return false;

    } on ServerExceptions {
       throw ServerFailure("Error ");
    }
  }

}