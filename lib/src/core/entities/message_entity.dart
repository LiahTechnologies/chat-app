import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
// part 'message_entity.g.dart';

@HiveType(typeId: 1)
class MessageEntity extends Equatable {

  @HiveField(0)
  final String? messageId;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final String messageSender;

  @HiveField(3)
  final String senderId;

  @HiveField(4)
  final String? messageReceiver;

  @HiveField(5)
  final String receiverId;

  @HiveField(6)
  final String replySender;

  @HiveField(7)
  final String replyMessage;

  @HiveField(8)
  final String? chatId;

  @HiveField(9)
  final String time;

  const MessageEntity(
      { this.messageId,
      required this.message,
       this.messageReceiver,
      required  this.senderId,
      required this.receiverId,
      required this.messageSender,
      required this.replyMessage,
      required this.replySender,
       this.chatId,
      required this.time});

  @override
  List<Object?> get props => [
        messageId,
        messageReceiver,
        messageSender,
        replyMessage,
        replySender,
        time,
        chatId
      ];

factory MessageEntity.fromjson(Map<String,dynamic>json)=>MessageEntity(message: json["message"], messageSender: json["senderId"], replyMessage: json["receiverId"], replySender: json["replySender"], time: json["time"],senderId: json['senderId'], receiverId: json['receiverId']);
}
