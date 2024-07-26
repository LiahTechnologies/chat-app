import 'package:equatable/equatable.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/chat.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/message.dart';

// THESE ARE EVEN FRO CHATMESSAGE
class ChatMessageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnChatMessageLoading extends ChatMessageEvent {
  final String chatId;

  OnChatMessageLoading({required this.chatId});

  @override
  List<Object?> get props => [chatId];
}

class OnChatMessageLoaded extends ChatMessageEvent {}

class OnChatMessageDeleted extends ChatMessageEvent {
  final String chatId;
  final ChatMessage message;

  OnChatMessageDeleted({required this.chatId, required this.message});

  @override
  List<Object?> get props => [chatId, message];
}


class OnChatMessageSent extends ChatMessageEvent {
  final String chatId;
  final ChatMessage message;

  OnChatMessageSent({required this.chatId, required this.message});

  @override
  List<Object?> get props => [chatId, message];
}


class OnChatMessageError extends ChatMessageEvent {}





// this is the event for chat

class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnFetchChats extends ChatEvent {

  OnFetchChats();

  @override
  List<Object?> get props => [];
}

class OnDeleteChat extends ChatEvent {}

// class OnChatError extends ChatEvent {}
