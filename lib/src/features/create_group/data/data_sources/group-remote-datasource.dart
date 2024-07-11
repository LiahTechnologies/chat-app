import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:njadia/src/core/common/urls.dart';
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart';
import 'package:njadia/src/features/create_group/data/model/group-model.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';

import '../../../../core/common/errors/exceptions.dart';
import '../../../../core/common/errors/failures.dart';

abstract class GroupRemoteDataSoucrce{
   Future<void> createGroup(GroupEntity groupEntity);

  Future<List<String>> groupAdmins({required String groupId});
  Future<List<String>> groupMembers({required String groupId});

  Future<String> addAdmins({required String groupId, required String adminId});
  Future<String> addMembers({ required String groupId,required String memberId });

  Future<String> deleteAdmins({required String groupId, required String adminId});
  Future<String> deleteMembers({required String groupId, required String memberId});


}


class GroupRemoteDataSourceImpl extends GroupRemoteDataSoucrce{
   final http.Client client;
    
   GroupRemoteDataSourceImpl({required this.client});



   
  @override
  Future<void> createGroup(GroupEntity groupEntity)  async{
   try {
    final data =GroupModel(groupName: groupEntity.groupName, groupIcon: groupEntity.groupIcon, members: groupEntity.members, admins: groupEntity.admins, levy: groupEntity.levy,limit: groupEntity.limit).toJson();
     
      print("${data}    ${AppUrls.groups}");
     final response =  await client.post(Uri.parse(AppUrls.groups),body: json.encode(data),headers: {"Content-Type": "Application/json"});
      print("THE RESPONSE STATUS CODE ${response.statusCode}");
      if(response.statusCode==201){
        print("Group Created");
      }
   

   } 
   on ServerExceptions {
     throw ServerExceptions();
   }
  }
  




  @override
  Future<String> addAdmins({required String groupId,  required String adminId}) async{
    try {

     final response =  await client.patch(Uri.parse(AppUrls.groupAdmin+groupId),body:{"adminId":adminId} );
      
      if(response.statusCode==200){
        print("Group Created");
        
      }
   
   return "Admin Added";

   } 
   on ServerExceptions {
     throw ServerExceptions();
   }
  }
  



  @override
  Future<String> addMembers({required String groupId, required String memberId})async {
    try {

     final response =  await client.patch(Uri.parse(AppUrls.groupMembers+groupId),body:{"memberId":memberId} );
      
      if(response.statusCode==200){
        print("Group Created");
        
      }
   
   return "Members Added";

   } 
   on ServerExceptions {
     throw ServerExceptions();
   }
  }
  



  @override
  Future<String> deleteAdmins({required String groupId, required String adminId})async {
    try {

     final response =  await client.delete(Uri.parse(AppUrls.groupAdmin+groupId),body:{"adminId":adminId} );
      
      if(response.statusCode==200){
        print("Group Created");
        
      }
   
   return "Admin Deleted";

   } 
   on ServerExceptions {
     throw ServerExceptions();
   }
  }



  
  @override
  Future<String> deleteMembers({required String groupId, required String memberId}) async {
     try {

     final response =  await client.delete(Uri.parse(AppUrls.groupMembers+groupId),body:{"memberId":memberId} );
      
      if(response.statusCode==200){
        print("Group Created");
        
      }
   
   return "Members Deleted";

   } 
   on ServerExceptions {
     throw ServerExceptions();
   }
  }
  



  @override
  Future<List<String>> groupAdmins({required String groupId})async {
     try {

     final response =  await client.get(Uri.parse(AppUrls.groupAdmin+groupId) );
      
      if(response.statusCode==200){
        print("Group Created");
        
      }
   
   return json.decode(response.body).map<UserModel>((user)=>UserModel.fromjson(user)).toList() ;

   } 
   on ServerExceptions {
     throw ServerExceptions();
   }
  
  }


  
  @override
  Future<List<String>> groupMembers({required String groupId}) async{
    try {

     final response =  await client.get(Uri.parse(AppUrls.groupMembers+groupId) );
      
      if(response.statusCode==200){
        print("Group Created");
        
      }
   
   return json.decode(response.body).map<UserModel>((user)=>UserModel.fromjson(user)).toList() ;

   } 
   on ServerExceptions {
     throw ServerExceptions();
   }
  }


}