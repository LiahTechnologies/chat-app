import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  final String? messageId;
  final String message;
  final String messageSender;
  final String messageReceiver;
  final String? chatId;
  final String replySender;
  final String replyMessage;
  final String time;
  final String senderId;
  final String receiverId;

  const MessageModel(
      { this.messageId,
      required this.message,
      required this.messageReceiver,
      required this.messageSender,
      required this.replyMessage,
      required this.replySender,
      required this.senderId,
      required this.receiverId,
       this.chatId,
      required this.time})
      : super(
            messageId: messageId,
            message: message,
            messageReceiver: messageReceiver,
            messageSender: messageSender,
            replyMessage: replyMessage,
            replySender: replySender,
            time: time,
            chatId: chatId,
            senderId: senderId,
            receiverId: receiverId,
            
            );

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      messageId: json["messageId"],
      message: json["message"],
      messageReceiver: json["messageReceiver"],
      messageSender: json["messageSender"],
      replyMessage: json["replyMessage"],
      replySender: json["replySender"],
      time: json["dateTime"],
      chatId: json['chatId'],
      senderId: json['senderId'],
      receiverId: json['receiverId']
      );

  Map<String, dynamic> toJson() => {
       "messageId": messageId,
      "message": message,
      "messageReceiver": messageReceiver,
      "messageSender":messageSender,
      "replyMessage": replyMessage,
      "replySender": replySender,
      "dateTime": time,
      "chatId":chatId,
      "senderId":senderId,
      "receiverId":receiverId
      };
}
