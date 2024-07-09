import 'package:equatable/equatable.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/message.dart';

import '../../domain/entities/chat.dart';

class ChatMessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatMessageEmpty extends ChatMessageState {}

class ChatMessageLoading extends ChatMessageState {}

class ChatMessageLoaded extends ChatMessageState {
  final ChatMessage chatMessage;
  ChatMessageLoaded({required this.chatMessage});

  List<Object?> get props => [chatMessage];
}

// class ChatLoaded extends ChatMessageState {
//   final ChatMessage chatMessage;
//   ChatLoaded({required this.chatMessage});

//   List<Object?> get props => [chatMessage];
// }

class ChatMessageErrorLoading extends ChatMessageState {}




/****CHAT LIST*** */

class ChatState extends Equatable {
  ChatState({required this.chat});
  final List<Chat> chat;
  @override
  List<Object?> get props => [chat];
}

class ChatEmpty extends ChatState {
  ChatEmpty({required super.chat});

  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {
  ChatLoading() : super(chat: []);
}

class ChatLoaded extends ChatState {
  final List<Chat> chat;
  ChatLoaded({required this.chat}) : super(chat: chat);

  @override
  List<Object?> get props=>[chat];
}

class ChatErrorLoading extends ChatState {
  ChatErrorLoading() : super(chat: []);
}
