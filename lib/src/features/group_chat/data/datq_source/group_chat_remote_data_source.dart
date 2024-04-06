import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/exceptions.dart';
import 'package:njadia/src/features/group_chat/data/model/group_chat_model.dart';
import 'package:njadia/src/features/group_chat/domain/entities/message_entity.dart';
import 'package:http/http.dart' as http;

import '../../../../common/services/readjons.dart';

abstract class GroupChatRemoteDataSource {
  Future< bool> sendMessage(
      {required MessageEntity messageEntity, required String groupId});

  Future< GroupChatModel> fetchMessage(
      {required String groupId});

  Future< bool> deleteMessage(
      {required String groupId, required MessageEntity messageEntity});
}





class GroupChatRemoteDataSourceImpl extends GroupChatRemoteDataSource {
  final http.Client client;
  GroupChatRemoteDataSourceImpl({required this.client});



  @override
  Future< bool> deleteMessage(
      {required String groupId, required MessageEntity messageEntity}) async {
    try {
      // final response = await client.delete(Uri.parse(AppUrls.BASEURL),body: messageEntity);

      final message = GroupChatModel.fromJson(
          json.decode(readJson('../../../../common/services/chat-data.json')));

      return true;
    } on ServerExceptions {
      throw ServerExceptions();
    }


  }




  @override
  Future< GroupChatModel> fetchMessage(
      {required String groupId}) async {
    
    try {
      // final response = await client.get(Uri.parse(AppUrls.BASEURL));

      final message = GroupChatModel.fromJson(
          json.decode(readJson('../../../../common/services/chat-data.json')));

      return message;
    } on ServerExceptions {
      throw Left(ServerExceptions);
    }
  }




  @override
  Future<bool> sendMessage(
      {required MessageEntity messageEntity, required String groupId}) async{
   
   try {
      // final response = await client.get(Uri.parse(AppUrls.BASEURL));

      final message = GroupChatModel.fromJson(
          json.decode(readJson('../../../../common/services/chat-data.json')));

      return true;
    } on ServerExceptions {
      throw Left(ServerExceptions);
    }
  }



}
