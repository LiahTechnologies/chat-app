import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:http/http.dart' as http;
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:socket_io_client/socket_io_client.dart';
import '../../../../core/common/services/readjons.dart';
import '../../../../core/common/urls.dart';
import '../../../../core/entities/stream_socket.dart';
import '../model/group_chat_model.dart';

abstract class GroupChatRemoteDataSource {
  Future<String> sendMessage(
      {required MessageEntity messageEntity, required String groupId});

  Future<List<GroupChatModel>> fetchMessage({required String groupId});

  // Future<List<GroupChatModel>> fetchGroup({required String groupId});

  Future<bool> deleteMessage(
      {required String groupId, required MessageEntity messageEntity});
}

class GroupChatRemoteDataSourceImpl extends GroupChatRemoteDataSource {
  final http.Client client;
  GroupChatRemoteDataSourceImpl({required this.client});
  StreamSocket streamSocket = StreamSocket();

  @override
  Future<bool> deleteMessage(
      {required String groupId, required MessageEntity messageEntity}) async {
    try {
      // final response = await client.delete(Uri.parse(AppUrls.BASEURL),body: messageEntity);

      final message = GroupChatModel.fromJson(
         await readJson('lib/src/core/common/services/chat-data.json'));

      return true;
    } on ServerExceptions {
      throw ServerExceptions();
    }
  }

  @override
  Future<List<GroupChatModel>> fetchMessage({required String groupId}) async {
    try {
      // final response = await client.get(Uri.parse(AppUrls.BASEURL));

      final message = GroupChatModel.fromJson(
         await readJson('lib/src/core/common/services/chat-data.json'));

      return [message];
    } on ServerExceptions {
      throw Left(ServerExceptions);
    }
  }
  
  @override
  Future<String> sendMessage({required MessageEntity messageEntity, required String groupId})async {
    try {
      final data =GroupChatModel( message: messageEntity.message, messageReceiver: messageEntity.messageReceiver, messageSender: messageEntity.messageSender, replyMessage: messageEntity.replyMessage, replySender: messageEntity.replySender, dateTime: messageEntity.dateTime).toJson() ;


      print("THIS IS THE SENT MESSAGE $data");

      final response =client.post(Uri.parse(AppUrls.sendMessage+groupId),body:json.encode(data), headers: {"content-type":"application/json"});

     

      return  "";

    } on ServerExceptions {
      throw Left(ServerExceptions);
    }
  }



/*
  @override
  Stream<MessageEntity> sendMessage(
      {required MessageEntity messageEntity, required String channel_id}) {
    try {
      IO.Socket socket = IO.io('http://localhost:3000',
          OptionBuilder().setTransports(['websocket']).build());

      socket.onConnect((_) {
        print('connect');
        socket.emit('msg', 'test');
      });

      socket.on('event', (data) => streamSocket.addResponse);
      socket.onDisconnect((_) => print('disconnect'));
      return streamSocket.getResponse;
    } on ServerExceptions {
      throw Left(ServerExceptions);
    }
  }


  @override
  Future<List<GroupChatModel>> fetchGroup({required String groupId}) async {
    try {
      print("THE CURRENT GROUP ID IS ${groupId}");
      // final response = await client
      //     .post(Uri.parse(AppUrls.BASEURL), body: {"userId": groupId});

      final message = GroupChatModel.fromJson(
          json.decode(readJson('../../../../common/services/groups.json')));
      print("THIS IS THE MESSAGE ${message}");
      return [message];
    } on ServerExceptions {
      throw ServerExceptions();
    }
  }


  // @override
  // Future <List<GroupChatModel>> fetchGroup({required String userId}) async {

  // }

  */
}
