import 'package:njadia/src/core/entities/message_entity.dart';

import '../../domain/entities/message.dart';

class ChatMessageModel extends MessageEntity {
  ChatMessageModel({
    required this.message,
    required this.messageId,
    required this.sendId,
    required this.sender,
    required this.replyMessage,
    required this.replySender,
    required this.recepientId,
    required this.time,
     
    required this.chatId
  }) : super(senderId: sendId, receiverId: recepientId,messageId: messageId, message: message, messageReceiver: recepientId, messageSender: sender, replyMessage: replyMessage, replySender: replySender, chatId: chatId, time: time);
  final String message;
  final String messageId;
  final String sendId;
  final String sender;

  final String replyMessage;
  final String replySender;
  final String recepientId;
  final String time;
  final String chatId;


 
  factory ChatMessageModel.fromjson(Map<String, dynamic> json) =>
      ChatMessageModel(
          message: json["message"],
          messageId: json["messageId"],
          sendId: json["sendId"],
          sender: json["sender"],
          replyMessage: json["replyMessage"],
          replySender: json["replySender"],
          recepientId: json["recepientId"],
          time: json["time"],
          chatId: json["chatId"]);

@override
  Map<String, dynamic> toJson() => {
        "message": message,
        "messageId": messageId,
        "sendId": sendId,
        "sender": sender,
        "replyMessage": replyMessage,
        "replySender": replySender,
        "recepientId": recepientId,
        "time": time,
        "chatId": chatId
      };
}
