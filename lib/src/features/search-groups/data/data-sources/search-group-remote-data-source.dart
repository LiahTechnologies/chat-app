

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/core/common/urls.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:http/http.dart' as http;

import '../../../group_chat/data/model/group_list_model.dart';

abstract class SearchGroupRemoteDataSource{
  Future< GroupChatEntity> findGroup({required String groupName});
  Future<bool> hasUserJoined({required String groupId});
  Future<bool>joinGroup({required String groupId, required String uid});
}


class SearchGroupRemoteDataSourceImpl extends SearchGroupRemoteDataSource{

    final http.Client client;

    SearchGroupRemoteDataSourceImpl({required this.client});


  @override
  Future< GroupChatEntity> findGroup({required String groupName}) async{
    
     try {

      final result = await client.get(Uri.parse(AppUrls.groups+"/"+groupName),headers: {"content-type":"application/json"});

       
       
        final group=  await GroupModel.fromJson(json.decode(result.body));
        
       
        return group;
     } on ServerExceptions {
        throw ServerFailure("Error Fetching data");
     }
  }
  
  @override
  Future<bool> hasUserJoined({required String groupId})  async{

    final uid = await HelperFunction.getUserID();
    try {
      final result = await client.post(Uri.parse(AppUrls.groups+"/member/"+groupId),body: json.encode({"id":uid}),headers:{"content-type":"application/json"});
        print("DATABASE RESPONSE ${json.decode(result.body)}");
        return json.decode(result.body) as bool;
    } on ServerExceptions {
      throw ServerFailure("Error checking");
    }
  }
  
  @override
  Future< bool> joinGroup({required String groupId, required String uid}) async{
   try {
     
     final result = await client.patch(Uri.parse(AppUrls.groupMembers+"/"+groupId),body: json.encode({"userId":uid}), headers: {"content-type":"application/json"});
     final status = json.decode(result.body);
     print("USER JOINDE STATUS ${status['message']} UserId $uid");

     return status['message'] as bool;
   } on ServerExceptions {
     throw Left(ServerFailure("Error Adding user"));
   }
  }

}