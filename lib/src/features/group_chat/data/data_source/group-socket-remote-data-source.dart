import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/core/common/urls.dart';
import 'package:njadia/src/features/group_chat/data/model/group_chat_model.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group-socket-bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/common/errors/exceptions.dart';
import '../../../../core/common/errors/failures.dart';

abstract class SocketRemoteDataSource {
  void connect();
  void disconnect();
  void sendMessage(String event, dynamic data);

  Future<void> onMessage(String event, Function(dynamic) callback);
  Future<List<GroupChatModel>> fetchInitialMessages(String groupId);
  Future<bool>addChat({required String uid, required String receiverId});

}

class SocketRemoteDataSourceImpl implements SocketRemoteDataSource {
  late IO.Socket socket;
  late http.Client client;
  SocketRemoteDataSourceImpl(this.client);
  @override
  void connect() async {
    print("THE CONNECTION IS BEING CALLED");
    socket = IO.io(AppUrls.SOCKET_URL, <String, dynamic>{
      "query":{
          "userId":await HelperFunction.getUserID()
      },
      'transports': ['websocket'],
      "autoConnect": false,



    });
    socket.connect();

    socket.on('connect', (_) {
      print('User connected');
    });

    // socket.on("OnGroup",(data){
    //    SocketBloc.
    // });
   


    socket.on('disconnect', (_) {
      print('User disconnected');
    });
  }
  

  @override
  void disconnect() {
    socket.disconnect();
  }

  @override
  void sendMessage(String event, dynamic data) {
    print("THIS IS THE SEND MESSAGE EVENT $data");
    // socket.on(event,(data));
    socket.emit(event, data);
  }



  @override
  Future<void> onMessage(String event, Function(dynamic) callback) async{
    socket.on(event, (data)async{
      await callback(data);
    });
  }



  @override
  Future<List<GroupChatModel>> fetchInitialMessages(String groupId) async {
    final currentUser =await HelperFunction.getUserID();

    final data = {
      "uid":currentUser,
      "groupId":groupId
    };

    final response = await http.post(Uri.parse("${AppUrls.BASEURL}messages/init"),body: json.encode(data),headers: {"Content-Type": "Application/json"});
    // print("FETCHED MESSAGE STATUS CODE ${json.decode(response.body)}");

    if (response.statusCode == 200) {
      // print("MESSAGES FETCHED SUCCESSFULLY");
      Iterable messages =  json.decode(response.body);
      List<GroupChatModel> groupChats = List<GroupChatModel>.from(messages.map((e)=>GroupChatModel.fromJson(e)));

      return groupChats;
    } else {
      throw Exception('Failed to load messages');
    }
  }


  @override
  Future<bool> addChat({required String uid, required String receiverId})async {
   try {
     print("SEND THE REQUEST TO THE BACKED TO ADD A CHAT $uid  reci $receiverId");

     final result = await http.patch(Uri.parse("${AppUrls.userChats}$uid"), body: json.encode({"userId":receiverId}),headers: {"Content-Type": "Application/json"});
     
        final data = json.decode(result.body);
        print("RESPONSE FROM DATABASE CHAT $data");
     return data["message"] as bool;
   } on ServerExceptions {
      throw ServerFailure("error adding chats");
   }
  }
}




