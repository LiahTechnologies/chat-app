import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
// part 'message_entity.g.dart';



class MessageEntity extends Equatable {

 
  final String? messageId;


  final String message;

  
  final String messageSender;

  
  final String senderId;

 
  final String? messageReceiver;

 
  final String receiverId;

  final String replySender;

 
  final String replyMessage;

  
  final String? chatId;

 
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
