import 'package:hive_flutter/hive_flutter.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
part 'group_list_model.g.dart';


@HiveType(typeId: 2)
class GroupModel extends GroupChatEntity {
  @HiveField(1)
  final String? id;
  @HiveField(2)
  final String? groupName;
  @HiveField(3)
  final String? profilePic;
  @HiveField(4)
  final String? unreadMessage;
  // final List<MessageEntity> messages;

  GroupModel({
    required this.groupName,
    required this.id,
    required this.profilePic,
    required this.unreadMessage,
    // required this.messages
  }) : super(
          groupName: groupName!,
          id: id,
          profilePic: profilePic,
          unreadMessage: unreadMessage,
          // message: messages
        );

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        groupName: json["groupName"],
        id: json["_id"],
        profilePic: json["groupIcon"],
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
