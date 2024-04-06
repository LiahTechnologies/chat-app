import 'package:equatable/equatable.dart';
import 'package:njadia/src/features/group_chat/domain/entities/message_entity.dart';

class GroupChatEntity extends Equatable {
  final String id;
  final String groupName;
  final String limit;
  final String levy;
  final List<MessageEntity> message;

  const GroupChatEntity(
    
      {required this.groupName,
      required this.id,
      required this.levy,
      required this.limit,
      required this.message
      });
  @override
  List<Object?> get props => [id, groupName, levy, limit,message];
}
