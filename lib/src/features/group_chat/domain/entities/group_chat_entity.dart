import 'package:equatable/equatable.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

class GroupChatEntity extends Equatable {
  final String? id;
  final String? groupName;
  final String? profilePic;
  final String? unreadMessage;
  // final List<MessageEntity> message;

  const GroupChatEntity(
    
      {required this.groupName,
      required this.id,
      required this.profilePic,
      required this.unreadMessage,
      // required this.message
      });
  @override
  List<Object?> get props => [id, groupName, profilePic, unreadMessage
  // ,message
  ];
}
