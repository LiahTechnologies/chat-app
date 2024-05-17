import 'package:equatable/equatable.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

class GroupChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGroupChatLoading extends GroupChatEvent {}
class GroupChatLoad extends GroupChatEvent {
  final MessageEntity message;
  final String groupId;

  GroupChatLoad({required this.message, required this.groupId});

   @override
  List<Object?> get props => [message,groupId];
}



class OnGroupChatSent extends GroupChatEvent {
  final MessageEntity message;
  final String groupId;

  OnGroupChatSent({required this.message, required this.groupId});

   @override
  List<Object?> get props => [message,groupId];
}

class OnGroupChatDelete extends GroupChatEvent {}

class OnGroupChatError extends GroupChatEvent {}



