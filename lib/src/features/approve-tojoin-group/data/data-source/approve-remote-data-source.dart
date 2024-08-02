

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/urls.dart';
import 'package:njadia/src/features/payment/data/model/user-entity-model.dart';

import '../../../../core/common/errors/failures.dart';
import '../../../payment/domain/entity/group-members.dart';
import 'package:http/http.dart' as http;
abstract class ApproveRemoteDataSource{
   Future<Either<Failure,List<GroupMembers>>> getPendingRequest({required String groupId});
  Future<Either<Failure,bool>> approvePendingRequest({required String groupId, required String userId});
  Future<Either<Failure,bool>> rejectPendingRequest({required String groupId, required String userId});

}

class ApproveRemoteDataSourceImpl extends ApproveRemoteDataSource{

  ApproveRemoteDataSourceImpl({required this.client});
  final http.Client client;


  @override
  Future<Either<Failure, bool>> approvePendingRequest({required String groupId, required String userId}) async {
    try {
      print("APPROVE USE ");
      final result = await client.patch(Uri.parse("${AppUrls.groupMembers}$groupId"), body: json.encode({"userId":userId}),headers: {"content-type":"application/json"});
      final data = json.decode(result.body);
      return Right(data['message'] as bool);
      
    } on ServerExceptions {
      throw Left(ServerFailure("Error"));
    }
  }

  @override
  Future<Either<Failure, List<GroupMembers>>> getPendingRequest({required String groupId}) async{
    
    try {

      print("FETCHING PENDING REQUEST $groupId");
      final result = await client.get(Uri.parse("${AppUrls.joinGroup}$groupId"), headers: {"content-type":"application/json"});
      print("Pending reques ${json.decode(result.body)}");


      Iterable data = json.decode(result.body);

      List<GroupMembers> pendingMembers = List<GroupMembers>.from(data.map((e)=>GroupMembersModel.fromjson(e)));

      return Right(pendingMembers);
      
    } on ServerExceptions {
      throw Left(ServerFailure("Error"));
    }
  }

  @override
  Future<Either<Failure, bool>> rejectPendingRequest({required String groupId, required String userId}) async{
     try {
      final result = await client.delete(Uri.parse("${AppUrls.joinGroup}$groupId"), body: json.encode({"userId":userId}),headers: {"content-type":"application/json"});
      final data = json.decode(result.body);
      return Right(data['message'] as bool);
      
    } on ServerExceptions {
      throw Left(ServerFailure("Error"));
    }
  }

}