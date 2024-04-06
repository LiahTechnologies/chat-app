// class Message {
//   final String text;
//   final String sender;
//   final String time;

//   Message({required this.sender, required this.text, required this.time});
// }

class ChatMessage {
  final String message;
  final String messageId;
  final String sendId;
  final String sender;
  final String replyMessage;
  final String replySender;
  final String recepientId;
  final String time;
  final String? chatId;

  ChatMessage(
      {required this.message,
      required this.messageId,
      required this.recepientId,
      required this.replyMessage,
      required this.replySender,
      required this.sendId,
      required this.sender,
      required this.time,
      this.chatId});

  factory ChatMessage.fromjson(Map<String, dynamic> json) => ChatMessage(
      message: json["message"],
      messageId: json["messageId"],
      recepientId: json["recepientId"],
      replyMessage: json["replyMessage"],
      replySender: json["replySender"],
      sendId: json["sendId"],
      sender: json["sender"],
      time: json["time"]);


      
  Map<String, dynamic> toJson() => {
        "message": message,
        "messageId": messageId,
        "recepientId": recepientId,
        "replyMessage": replyMessage,
        "replySender": replySender,
        "senderId": sendId,
        "sender": sender,
        "time": time,
        "chatId": chatId
      };
}
