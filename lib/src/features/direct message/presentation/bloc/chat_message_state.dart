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

class ChatState extends Equatable {
  ChatState();

  @override
  List<Object?> get props => [];
}

class ChatEmpty extends ChatState {
  ChatEmpty();

  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {
  ChatLoading();
}

class ChatLoaded extends ChatState {
  final Chat chat;
  ChatLoaded({required this.chat});

  @override
  List<Object?> get props=>[chat];
}

class ChatErrorLoading extends ChatState {
  ChatErrorLoading();
}
