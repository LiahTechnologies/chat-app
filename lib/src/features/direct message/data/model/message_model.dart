import '../../domain/entities/message.dart';

class ChatMessageModel extends ChatMessage {
  final String message;
  final String messageId;
  final String sendId;
  final String sender;
  final String replyMessage;
  final String replySender;
  final String recepientId;
  final String time;
  final String? chatId;

  ChatMessageModel(
      {required this.message,
      required this.messageId,
      required this.sendId,
      required this.sender,
      required this.replyMessage,
      required this.replySender,
      required this.recepientId,
      required this.time,
      required this.chatId})
      : super(
            message: message,
            messageId: messageId,
            recepientId: recepientId,
            replyMessage: replyMessage,
            replySender: replySender,
            sendId: sendId,
            sender: sender,
            time: time);


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
}
