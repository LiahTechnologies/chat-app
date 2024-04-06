import '../../domain/entities/chat.dart';

class ChatModel extends Chat {
  final String chatId;
  final String profilPic;
  final String chatName;
  @override
  // final List<ChatMessage> messages;
  ChatModel({
    required this.chatId,
    required this.profilPic,
    required this.chatName
  }) : super(chatId: chatId, profilPic: profilPic, chatName:chatName);

  factory ChatModel.fromjson(Map<String, dynamic> json) => ChatModel(
        chatId: json["chatId"],
        profilPic: json["profilPic"],
        chatName: json["chatName"]
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "profilPic": profilPic,
        "chatName":chatName
      };
}
