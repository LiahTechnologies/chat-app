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
  final String dateTime;

  const GroupChatModel(
      { this.messageId,
      required this.message,
       this.messageReceiver,
      required this.messageSender,
      required this.replyMessage,
      required this.replySender,
       this.chatId,
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
      messageId: json["_id"],
      message: json["message"],
      messageReceiver: json["receiverId"],
      messageSender: json["senderId"],
      replyMessage: json["senderId"],
      replySender: json["receiverId"],
      dateTime: json["receiverId"],
      chatId: json['message']
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
