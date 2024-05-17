import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

class GroupChatModel extends MessageEntity {
  final String messageId;
  final String message;
  final String messageSender;
  final String messageReceiver;
  final String chatId;
  final String replySender;
  final String replyMessage;
  final String dateTime;

  const GroupChatModel(
      {required this.messageId,
      required this.message,
      required this.messageReceiver,
      required this.messageSender,
      required this.replyMessage,
      required this.replySender,
      required this.chatId,
      required this.dateTime})
      : super(
            messageId: messageId,
            message: message,
            messageReceiver: messageReceiver,
            messageSender: messageSender,
            replyMessage: replyMessage,
            replySender: replySender,
            dateTime: dateTime,
            chatId: chatId
            
            );

  factory GroupChatModel.fromJson(Map<String, dynamic> json) => GroupChatModel(
      messageId: json["messageId"],
      message: json["message"],
      messageReceiver: json["messageReceiver"],
      messageSender: json["messageSender"],
      replyMessage: json["replyMessage"],
      replySender: json["replySender"],
      dateTime: json["dateTime"],
      chatId: json['chatId']
      );

  Map<String, dynamic> toJson() => {
       "messageId": messageId,
      "message": message,
      "messageReceiver": messageReceiver,
      "messageSender":messageSender,
      "replyMessage": replyMessage,
      "replySender": replySender,
      "dateTime": dateTime,
      "chatId":chatId
      };
}
