import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/core/common/urls.dart';
import 'package:njadia/src/features/group_chat/data/model/group_chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class SocketRemoteDataSource {
  void connect();
  void disconnect();
  void sendMessage(String event, dynamic data);

  void onMessage(String event, Function(dynamic) callback);
  Future<List<GroupChatModel>> fetchInitialMessages(String groupId);
}

class SocketRemoteDataSourceImpl implements SocketRemoteDataSource {
  late IO.Socket socket;

  @override
  void connect() async {
    print("THE CONNECTION IS BEING CALLED");
    socket = IO.io('http://192.168.34.98:5000', <String, dynamic>{
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
    //     print("SERVER RESPONSE $data");
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
    socket.emit(event, data);
  }

  @override
  void onMessage(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  @override
  Future<List<GroupChatModel>> fetchInitialMessages(String groupId) async {
    final currentUser =await HelperFunction.getUserID();

    final data = {
      "uid":currentUser,
      "groupId":groupId
    };

    final response = await http.post(Uri.parse(AppUrls.BASEURL+"messages/init"),body: json.encode(data),headers: {"content-type":"application/json"});
    print("FETCHED MESSAGE STATUS CODE ${json.decode(response.body)}");

    if (response.statusCode == 200) {
      print("MESSAGES FETCHED SUCCESSFULLY");
      Iterable messages =  json.decode(response.body);
      List<GroupChatModel> groupChats = List<GroupChatModel>.from(messages.map((e)=>GroupChatModel.fromJson(e)));

      return groupChats;
    } else {
      throw Exception('Failed to load messages');
    }
  }
}




