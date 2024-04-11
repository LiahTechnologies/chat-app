import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

class GroupChatModel extends GroupChatEntity {
  final String id;
  final String groupName;
  final String profilePic;
  final String unreadMessage;
  final List<MessageEntity> message;


  GroupChatModel(
      {required this.groupName,
      required this.id,
      required this.profilePic,
      required this.unreadMessage,
      required this.message
      })
      : super(
            groupName: groupName,
            id: id,
            profilePic: profilePic,
            unreadMessage: unreadMessage,
            message: message);


  factory GroupChatModel.fromJson(Map<String, dynamic> json) => GroupChatModel(
      groupName: json["groupName"],
      id: json["id"],
      profilePic: json["profilePic"],
      unreadMessage: json["unreadMessage"],
      message: json["message"]);


  Map<String, dynamic> toJson() => {
        "id": id,
        "groupName": groupName,
        "profilPic": profilePic,
        "unreadMessage": unreadMessage,
        "message": message
      };
}
