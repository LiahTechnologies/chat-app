import 'dart:convert';

import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/core/common/urls.dart';
import 'package:njadia/src/features/direct%20message/data/model/chat_model.dart';
import 'package:njadia/src/features/direct%20message/data/model/user-profile-model.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/message.dart';
import 'package:http/http.dart' as http;


abstract class PrivatChatListRemoteDataSource {
   Future<List<UserProfileModel>> fetchChats();

  Future<bool> deleteChat({required String receiverId});
}

class PrivatChatListRemoteDataSourceImpl extends PrivatChatListRemoteDataSource {
  final http.Client client;
  PrivatChatListRemoteDataSourceImpl({required this.client});
  

  @override
  Future<bool> deleteChat({required String receiverId}) {
    // TODO: implement deleteGroups
    throw UnimplementedError();
  }
  
  @override
  Future<List<UserProfileModel>> fetchChats()async {
    final currentUser = await HelperFunction.getUserID();
    try {

      final response = await client
          .get(Uri.parse(AppUrls.userChatList+currentUser), headers: {"content-type":"application/json"});

  // final groupJson = await readJson('lib/src/core/common/services/groups.json');

  // print("\n\n\nTHIS IS THE REMOTE DATA $groupJson");
   print("FETCHING CHATS FOR $currentUser");

   print("THESE ARE THE USER CHAS ${json.decode(response.body)}");

     Iterable chats = json.decode(response.body);
      
    

     List<UserProfileModel> chatList = List<UserProfileModel>.from(chats.map((data)=>UserProfileModel.fromJson(data)));

     print("serilized list ${chatList}");
     await HelperFunction.saveUserNumberOfChats("${chatList.length}");
      
      return chatList;
    } on ServerExceptions {
      print("STREAMS OF MESSAGES FAILED");
      throw ServerExceptions();
    }
  }
}
