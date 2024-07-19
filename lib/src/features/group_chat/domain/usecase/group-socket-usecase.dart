import 'package:njadia/src/core/entities/message_entity.dart';

import '../../data/repositories/group-socket-repositroy-impl.dart';
// import '../data/socket_repository.dart';

class ConnectSocket {
  final SocketsRepository repository;

  ConnectSocket(this.repository);

  void call() {
    repository.connect();
  }
}

class DisconnectSocket {
  final SocketsRepository repository;

  DisconnectSocket(this.repository);

  void call() {
    repository.disconnect();
  }
}

class SendMessage {
  final SocketsRepository repository;

  SendMessage(this.repository);

  void call(String event, dynamic data) {
    repository.sendMessage(event, data);
  }
}

class OnMessage {
  final SocketsRepository repository;

  OnMessage(this.repository);

  void call(String event, Function(dynamic) callback) {
    repository.onMessage(event, callback);
  }
}

class FetchInitialMessages {
  final SocketsRepository repository;

  FetchInitialMessages(this.repository);

  Future<List<MessageEntity>> call(String groupId) {
    return repository.fetchInitialMessages(groupId);
  }
}
