import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/core/common/urls.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:http/http.dart' as http;
import 'package:njadia/src/features/payment/data/model/user-entity-model.dart';

import '../../domain/entity/group-members.dart';


abstract  class GetGroupMemberRemoteDataSource{
  Future<Either<Failure,List<GroupMembers>>> getGroupMember({required String groupId});
}

class GetGroupMemberRemoteDataSourceImpl extends GetGroupMemberRemoteDataSource{
final http.Client client;

GetGroupMemberRemoteDataSourceImpl({required this.client});


  @override
  Future<Either<Failure,List<GroupMembers>>> getGroupMember({required String groupId}) async{
    try {
      print("Fetching GROUP MEMBERS $groupId");
      final result  = await client.get(Uri.parse("${AppUrls.groupMembers}$groupId"),headers: {"content-type":"application/json"});
      
      print("MEMBERS ${json.decode(result.body)}");
      Iterable data = json.decode(result.body);

      List<GroupMembers> members = List<GroupMembers>.from(data.map((e)=>GroupMembersModel.fromjson(e)));

      return Right(members);
      
    } on ServerExceptions {
       throw Left(ServerFailure("Error feteching members"));
    }
  }

}