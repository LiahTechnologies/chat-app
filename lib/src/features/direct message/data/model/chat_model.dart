import '../../domain/entities/chat.dart';

class ChatModel extends Chat {
  final String chatId;
  final String profilPic;
  final String userId;
  final String userName;
  final String time;
  final bool isGroup;
  final String lastMessage;
  @override
  // final List<ChatMessage> messages;
  ChatModel({
    required this.userName,
    required this.time, 
    required this.chatId,
    required this.profilPic,
    required this.userId,
    required this. isGroup,
    required this.lastMessage,

  }) : super(lastMessage: lastMessage,chatId: chatId, profilePic: profilPic, userName: userName,time: time,isGroup: isGroup);


  factory ChatModel.fromjson(Map<String, dynamic> json) => ChatModel(
        lastMessage:json['lastMessage'],
        chatId: json["chatId"],
        profilPic: json["profilPic"],
        userId: json["userId"],
        userName: json['firstName'],
        time: json['time'],
        isGroup: json['isGroup'],
        
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "profilPic": profilPic,
        "chatName":userId
      };
}
