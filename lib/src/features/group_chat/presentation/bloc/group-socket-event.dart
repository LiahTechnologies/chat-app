abstract class SocketEvent {}

class ConnectSocketEvent extends SocketEvent {}

class DisconnectSocketEvent extends SocketEvent {}

class SendMessageEvent extends SocketEvent {
  final String event;
  final dynamic data;

  SendMessageEvent(this.event, this.data);
}

class OnMessageEvent extends SocketEvent {
  final String event;
  final Function(dynamic) callback;

  OnMessageEvent(this.event, this.callback);
}

class FetchInitialMessagesEvent extends SocketEvent {
  final String groupId;

  FetchInitialMessagesEvent({required this.groupId});

}

class OnMessageEventReceived extends SocketEvent {
  final Map<String, dynamic> message;

  OnMessageEventReceived(this.message);
}


class OnAddChat extends SocketEvent{
  final String uid;
  final String receiverId;

  OnAddChat({required this.uid, required this.receiverId});
}

// class OnGenerateBallotsNumbers extends SocketEvent {
//   final String groupId;

//   OnGenerateBallotsNumbers({required this.groupId});
// }