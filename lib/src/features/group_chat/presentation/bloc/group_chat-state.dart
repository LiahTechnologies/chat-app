import 'package:equatable/equatable.dart';

import '../../../../core/entities/message_entity.dart';
import '../../domain/entities/group_chat_entity.dart';

class GroupChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GroupChatEmpty extends GroupChatState {}

class GroupChatLoading extends GroupChatState {}
class GroupChatSent extends GroupChatState {}
// class GroupBallotsGenerated extends GroupChatState {}

class GroupChatLoaded extends GroupChatState {
  final List<MessageEntity> messages;
  GroupChatLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];
}


class GroupChatError extends GroupChatState {
  final String error;
  GroupChatError({required this.error});

  List<Object ?> get props => [error];
}








