import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:njadia/src/core/common/urls.dart';
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart';
import 'package:njadia/src/features/create_group/data/model/group-model.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';

import '../../../../core/common/errors/exceptions.dart';
import '../../../../core/common/errors/failures.dart';

abstract class GroupRemoteDataSoucrce{
   Future<bool> createGroup(GroupEntity groupEntity, File profilePic);

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
  Future<bool> createGroup(GroupEntity groupEntity, File profilePic)  async{
   try {
     
  
  print("MAKING HTTP REQUEST TO CREATE GROUP");

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(AppUrls.uploadSinglFile),
    );

    var multipartFile =
        await http.MultipartFile.fromPath("file", profilePic.path);
  
    print("REQUEST STILL PENDING ");
    request.files.add(multipartFile);
    request.fields.addAll({"folder":"profile"});

   print("REQUEST STILL PENDING $request");

    var endpointResponse = await request.send();
   
   print("Request has been sent");
    var response = await http.Response.fromStream(endpointResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    print("FILE UPLOAD RESPONSE $result");

    if (endpointResponse.statusCode == 200) {
        print("CREATING GROUP WITH PROFILE PICS");

        final data =GroupModel(groupName: groupEntity.groupName, groupIcon: groupEntity.groupIcon, members: groupEntity.members, admins: groupEntity.admins, levy: groupEntity.levy,limit: groupEntity.limit,profilePic: result['file']).toJson();

        final response =  await client.post(Uri.parse(AppUrls.groups),body: json.encode(data),headers: {"Content-Type": "Application/json"});

        if(response.statusCode==201){
                  print("CREATING GROUP WITH PROFILE PICS 201");

            return true;
        }


      else
          throw ServerExceptions();


    } else
      throw ServerFailure("User was not created");


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