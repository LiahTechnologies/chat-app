import 'package:hive/hive.dart';
import 'package:njadia/src/features/group_chat/data/data_source/group-chat-model-ids.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

part 'group_chat_model.g.dart';

@HiveType(typeId: GroupChatTypeId.hiveType)
class GroupChatModel extends MessageEntity {
  @HiveField(GroupChatFieldId.messageId)
  final String? messageId;
  @HiveField(GroupChatFieldId.message)
  final String message;
  @HiveField(GroupChatFieldId.messageSender)
  final String messageSender;
  @HiveField(GroupChatFieldId.messageReceiver)
  final String? messageReceiver;
   @HiveField(GroupChatFieldId.chatId)
  final String? chatId;
   @HiveField(GroupChatFieldId.replySender)
  final String replySender;
  @HiveField(GroupChatFieldId.replyMessage)
  final String replyMessage;
   @HiveField(GroupChatFieldId.time)
  final String time;
  @HiveField(GroupChatFieldId.senderId)
  final String senderId;
   @HiveField(GroupChatFieldId.receiverId)
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
