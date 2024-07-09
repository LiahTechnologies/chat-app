import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

class GroupModel extends GroupChatEntity {
  final String id;
  final String groupName;
  final String profilePic;
  final String unreadMessage;
  // final List<MessageEntity> messages;

  GroupModel({
    required this.groupName,
    required this.id,
    required this.profilePic,
    required this.unreadMessage,
    // required this.messages
  }) : super(
          groupName: groupName,
          id: id,
          profilePic: profilePic,
          unreadMessage: unreadMessage,
          // message: messages
        );

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        groupName: json["groupName"],
        id: json["id"],
        profilePic: json["profilePic"],
        unreadMessage: json["unreadMessage"],
        // messages: json["messages"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupName": groupName,
        "profilPic": profilePic,
        "unreadMessage": unreadMessage,
        // "messages": messages
      };

  @override
  List<Object?> get props => [];
}
