import 'package:equatable/equatable.dart';

import '../../../../core/entities/message_entity.dart';
import '../../domain/entities/group_chat_entity.dart';

class GroupChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GroupchatEmpty extends GroupChatState {
   @override
  List<Object?> get props =>[];
}

class GroupChatLoading extends GroupChatState {
   @override
  List<Object?> get props => [];
}

class GroupChatLoaded extends GroupChatState {
  final MessageEntity messages;
  GroupChatLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class GroupChatSentState extends GroupChatState {
  final Stream messages;
  GroupChatSentState({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class GroupChatError extends GroupChatState {
   @override
  List<Object?> get props => [];
}








