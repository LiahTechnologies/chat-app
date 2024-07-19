import 'package:njadia/src/core/entities/message_entity.dart';

import '../datq_source/group-socket-remote-data-source.dart';

abstract class SocketsRepository {
  void connect();
  void disconnect();
  void sendMessage(String event, dynamic data);
  void onMessage(String event, Function(dynamic) callback);
  Future<List<MessageEntity>> fetchInitialMessages(String groupId);
}

class SocketRepositoryImpl implements SocketsRepository {
  final SocketRemoteDataSource remoteDataSource;

  SocketRepositoryImpl(this.remoteDataSource);

  @override
  void connect() {
    remoteDataSource.connect();
  }

  @override
  void disconnect() {
    remoteDataSource.disconnect();
  }

  @override
  void sendMessage(String event, dynamic data) {
    remoteDataSource.sendMessage(event, data);
  }

  @override
  void onMessage(String event, Function(dynamic) callback) {
    remoteDataSource.onMessage(event, callback);
  }

  @override
  Future<List<MessageEntity>> fetchInitialMessages(String groupId) {
    return remoteDataSource.fetchInitialMessages(groupId);
  }
}
