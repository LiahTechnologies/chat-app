import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/features/group_chat/domain/entities/message_entity.dart';

class GroupChatModel extends GroupChatEntity {
  final String id;
  final String groupName;
  final String limit;
  final String levy;
  final List<MessageEntity> message;

  GroupChatModel(
      {required this.groupName,
      required this.id,
      required this.levy,
      required this.limit,
      required this.message
      })
      : super(
            groupName: groupName,
            id: id,
            levy: levy,
            limit: limit,
            message: message);

  factory GroupChatModel.fromJson(Map<String, dynamic> json) => GroupChatModel(
      groupName: json["groupName"],
      id: json["id"],
      levy: json["levy"],
      limit: json["limit"],
      message: json["message"]);


  Map<String, dynamic> toJson() => {
        "id": id,
        "groupName": groupName,
        "limit": limit,
        "levy": levy,
        "message": message
      };
}
