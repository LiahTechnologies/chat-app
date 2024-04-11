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
 final Chat chat;
  ChatState({required this.chat});

  @override
  List<Object?> get props => [chat];
}

class ChatEmpty extends ChatState {
  ChatEmpty({required super.chat});

  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {
  ChatLoading({required super.chat});
}

class ChatLoaded extends ChatState {
  ChatLoaded({required super.chat});
 
}


class ChatErrorLoading extends ChatState {
  ChatErrorLoading({required super.chat});
}
