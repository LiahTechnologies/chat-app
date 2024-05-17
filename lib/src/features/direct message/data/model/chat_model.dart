import '../../domain/entities/chat.dart';

class ChatModel extends Chat {
  final String chatId;
  final String profilPic;
  final String userId;
  @override
  // final List<ChatMessage> messages;
  ChatModel({
    required this.chatId,
    required this.profilPic,
    required this.userId
  }) : super(chatId: chatId, profilePic: profilPic, userId:userId);


  factory ChatModel.fromjson(Map<String, dynamic> json) => ChatModel(
        chatId: json["chatId"],
        profilPic: json["profilPic"],
        userId: json["userId"]
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "profilPic": profilPic,
        "chatName":userId
      };
}
