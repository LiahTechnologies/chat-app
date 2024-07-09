import 'package:equatable/equatable.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';

class GroupChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}




class OnSentGroupMessage extends GroupChatEvent {
  final MessageEntity message;
  final String groupId;

  OnSentGroupMessage({required this.message, required this.groupId});

   @override
  List<Object?> get props => [message,groupId];
}



class OnFetchGroupMessage extends GroupChatEvent {
 
  final String groupId;

  OnFetchGroupMessage({ required this.groupId});

   @override
  List<Object?> get props => [groupId];
}

class OnDeleteGroupChat extends GroupChatEvent {
  final MessageEntity messageEntity;
  final String groupId;

  OnDeleteGroupChat({required this.groupId, required this.messageEntity});

  List<Object? > get props =>[groupId, messageEntity];
}

class OnGroupChatError extends GroupChatEvent {}



