import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/features/group_chat/data/model/group_list_model.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import '../../../../core/common/services/readjons.dart';
import '../../../../core/common/urls.dart';
import '../../../../core/entities/stream_socket.dart';
import '../../../../core/utils/internet-connection-checkr.dart';
import '../../../direct message/data/data_sources/local-data-source/local-chat-list-data-source.dart';
import 'local_message/local-chat-list-data-source.dart';

abstract class GroupListRemoteDataSource {
  Stream<List<GroupModel>> fetchGroup();
   Future<List<GroupModel>> fetchGroups();

  Future<bool> deleteGroups({required List<String> groups});
}

class GroupListRemoteDataSourceImpl extends GroupListRemoteDataSource {
  final http.Client client;
  GroupListRemoteDataSourceImpl({required this.client});
  StreamSocket streamSocket = StreamSocket();

      final InternetConnectionCheckerClass checkerClass =InternetConnectionCheckerClass();


  @override
 Stream<List<GroupModel>>fetchGroup() async* {
    try {

      print("STREAM FETCHING");

         final currentUser = await HelperFunction.getUserID();

        final response= await client.send(http.Request('GET',Uri.parse(AppUrls.userGroups+currentUser)));
        print("Looping STREAM RESULT");




/*

       List<GroupModel> users = [];

    await for (var chunk in response.stream.transform(utf8.decoder)) {
      // Split the chunk into lines if necessary
      final lines = chunk.split('\n');
       print("Looping STREAM RESULT 3");
      for (String line in lines) {
         print("Looping STREAM RESULT 5");
        if (line.isNotEmpty) {
          final Map<String, dynamic> jsonMap = jsonDecode(line);
           print("Looping STREAM RESULT 4 $jsonMap");


            if (jsonMap.containsKey('_id')) {
              final GroupModel user = GroupModel.fromJson(jsonMap);
              users.add(user);

              // Optionally yield the list of users as they are accumulated
              yield users;
            }
          // Extract and yield the user list
          

          print("Looping STREAM RESULT 4 $users");
          // Optionally yield the accumulated list of users
          yield users;
        }
      }
    }
*/











    List<GroupModel> users = [];

    await for (var chunk in response.stream.transform(utf8.decoder)) {
      // Split the chunk into lines
      final lines = chunk.split('\n');

      for (String line in lines) {
        if (line.isNotEmpty) {
           print("hmmm STREAM RESULT 4");
          try {
            final Map<String, dynamic> jsonMap = jsonDecode(line);

            if (jsonMap.containsKey('_id')) {
               print("USER STREAM RESULT 4 $jsonMap");
              final user = GroupModel.fromJson(jsonMap);
               print("USER STREAM RESULT 4 $user");
              users.add(user);

                print("Looping STREAM RESULT 4 $users");
              // Optionally yield the list of users as they are accumulated
              yield users;
            }
          } catch (e) {
            print('Error decoding JSON: $e');
          }
        }
      }
    }







    //  List<GroupModel> groupsList =[];
    //   await for (var data in response.stream.transform(utf8.decoder).transform(LineSplitter())) {
    //     print("THIS IS THE ANSWERS $data");
     
    //   final List<GroupModel> jsonList = jsonDecode(data) as List<GroupModel>;
     
    //     if (data.isNotEmpty) {

    //    groupsList =  jsonList.map((json) => GroupModel.fromJson(json)).toList();
    //       groupsList.add(GroupModel.fromJson(jsonDecode(line)));
    //       print("GROUP LIST $groupsList");
    //     }
      

    //   print("THIS ARE THE FETCHED GROUPS $groupsList");
    //   yield groupsList;
    // }
    
    } on ServerExceptions {
      print("STREAMS OF MESSAGES FAILED");
      throw ServerExceptions();
    }
  }

  @override
  Future<bool> deleteGroups({required List<String> groups}) async{
    print("THIS IS THE GROUP TO BE DELETED $groups");

    final uid = await HelperFunction.getUserID();
    print("User Id $uid  ${AppUrls.userChats}groups/$uid");
    final response = await client.delete(Uri.parse("${AppUrls.userChatList}groups/$uid"),body: json.encode({"groups":groups}),headers: {"content-type":"application/json"});

    if(response.statusCode==200)
    return true;
    else 
    return false;


  }
  
  @override
  Future<List<GroupModel>> fetchGroups()async {

   final LocalChatListDataSource listDataSource = LocalChatListDataSource(boxName: "groupList");


    final currentUser = await HelperFunction.getUserID();


    if(await checkerClass.init()){

    
    try {
      print("FETCH USER GROUPS");

      final response = await client
          .get(Uri.parse(AppUrls.userGroups+currentUser), headers: {"content-type":"application/json"});

      // final groupJson = await readJson('lib/src/core/common/services/groups.json');

              // print("\n\n\nTHIS IS THE REMOTE DATA $groupJson");
   
  //  print("THESE ARE THE USER GROUPS ${json.decode(response.body)}");

     Iterable groups = json.decode(response.body);
      
    

     List<GroupModel> groupsList = List<GroupModel>.from(groups.map((data)=>GroupModel.fromJson(data)));

     print("serilized list ${groupsList[0].id}");
     await HelperFunction.saveUserNumberOfGroups("${groupsList.length}");

     await listDataSource.insertGroupList(groupsList);
      
      return groupsList;
    } on ServerExceptions {
      print("STREAMS OF MESSAGES FAILED");
      throw ServerExceptions();
    }
  }
  else{
      return await listDataSource.getAllGroupList();
  }
  
  }
}
