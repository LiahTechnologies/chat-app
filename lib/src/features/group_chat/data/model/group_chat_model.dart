import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

class GroupChatModel extends MessageEntity {
  final String? messageId;
  final String message;
  final String messageSender;
  final String? messageReceiver;
  final String? chatId;
  final String replySender;
  final String replyMessage;
  final String time;
  final String senderId;
  final String receiverId;

  const GroupChatModel(
      { this.messageId,
      required this.message,
       this.messageReceiver,
      required this.messageSender,
      required this.replyMessage,
      required this.replySender,
       this.chatId,
       required this.senderId,
       required this.receiverId,
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
            receiverId: receiverId,
            senderId: senderId

            
            );

  factory GroupChatModel.fromJson(Map<String, dynamic> json) => GroupChatModel(
      message: json["message"],
      messageId: json["_id"],  
      messageReceiver: json["messageReceiver"],
      messageSender: json["messageSender"],
      replyMessage: json["replyMessage"]??"",
      replySender: json["replySender"]??"",
      time: json["time"]??"",
      chatId: json['_id'],
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
