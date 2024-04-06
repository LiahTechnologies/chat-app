import 'dart:convert';

import 'package:njadia/src/common/errors/exceptions.dart';
import 'package:njadia/src/common/urls.dart';
import 'package:njadia/src/features/direct%20message/data/model/chat_model.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/chat.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/message.dart';
import 'package:http/http.dart' as http;

abstract class ChatRemoteDataSource {
  Future<Chat> fetchChats(String userId);

  Future<bool> createChats(Chat chat);

  Future<bool> deleteChats(String chatId);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final http.Client client;

  ChatRemoteDataSourceImpl({required this.client});

  @override
  Future<Chat> fetchChats(String userId) async {
    try {
      final response = await client.get(Uri.parse(AppUrls.BASEURL));
      final jsonResponse = json.decode(response.body);
      return ChatModel.fromjson(jsonResponse);
    } on ServerExceptions {
      throw ServerExceptions();
    }
  }

  @override
  Future<bool> createChats(Chat chat) async {
    try {
      final response = await client.post(Uri.parse(AppUrls.BASEURL));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on ServerExceptions {
      throw ServerExceptions();
    }
  }

  @override
  Future<bool> deleteChats(String chatId) async{
     try {
      final response = await client.delete(Uri.parse(AppUrls.BASEURL),body: chatId);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on ServerExceptions {
      throw ServerExceptions();
    } 
  }
}


/********************* CHAT MESSAGEING PART************************ */


abstract class ChatMessageRemoteDataSource {
  Future<ChatMessage> fetchMessages(String chatId);

  Future<bool> sendMessage(ChatMessage chatMessage, String chatId);

  Future<bool> deleteMessage(ChatMessage message, String chatId);
}

class ChatMessageRemoteDataSourceImpl extends ChatMessageRemoteDataSource {
  final http.Client client;

  ChatMessageRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> deleteMessage(ChatMessage message, String chatId) async {
    try {
      final response =
          await client.delete(Uri.parse(AppUrls.BASEURL), body: {});
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerExceptions();
      }
    } on ServerExceptions {
      throw ServerExceptions();
    }
  }

  @override
  Future<ChatMessage> fetchMessages(String chatId) async {
    try {
      final response = await client.get(Uri.parse(AppUrls.BASEURL));
      final jsonResponse = ChatMessage.fromjson(json.decode(response.body));
      return jsonResponse;
    } on ServerExceptions {
      throw ServerExceptions();
    }
  }

  @override
  Future<bool> sendMessage(ChatMessage chatMessage, String chatId) async {
    try {
      final response = await client.post(Uri.parse(AppUrls.BASEURL),
          body: {"message": chatMessage, "chatId": chatId});

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerExceptions();
      }
    } on ServerExceptions {
      throw ServerExceptions();
    }
  }
}
