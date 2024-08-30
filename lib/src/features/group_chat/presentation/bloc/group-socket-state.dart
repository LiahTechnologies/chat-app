import 'package:njadia/src/core/entities/message_entity.dart';

abstract class SocketState {}

class SocketInitialState extends SocketState {}

class SocketConnectingState extends SocketState {}

class SocketConnectedState extends SocketState {
  // final List<MessageEntity> messages;

  // SocketConnectedState( this.messages);

}

class SocketDisconnectedState extends SocketState {}

class SocketMessageReceivedState extends SocketState {
  final dynamic message;

  SocketMessageReceivedState(this.message);
}



class InitialMessagesFetchedState extends SocketState {
  final List<MessageEntity> messages;

  InitialMessagesFetchedState(this.messages);
}



class SocketErrorState extends SocketState {
  final String message;

  SocketErrorState(this.message);
}



class PrivateChatCreated extends SocketState{
  final bool status;

  PrivateChatCreated(this.status);

}

class GroupBallotsGenerated extends SocketState {}