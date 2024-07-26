import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

import '../../../../core/common/errors/failures.dart';
import '../../data/repository/socket-repository.dart';
// import '../data/socket_repository.dart';

class PrivateConnectSocket {
  final PrivateSocketsRepository repository;

  PrivateConnectSocket(this.repository);

  void call() { 

    repository.connect();
  }
}

class DisconnectPrivateSocket {
  final PrivateSocketsRepository repository;

  DisconnectPrivateSocket(this.repository);

  void call() {
    repository.disconnect();
  }
}

class SendPrivateMessage {
  final PrivateSocketsRepository repository;

  SendPrivateMessage(this.repository);

  void call(String event, MessageEntity data) {
    repository.sendMessage(event, data);
  }
}

class OnPrivateMessage {
  final PrivateSocketsRepository repository;

  OnPrivateMessage(this.repository);

  void call(String event, Function(dynamic) callback) {
    repository.onMessage(event, callback);
  }
}

class FetchInitialPrivateMessages {
  final PrivateSocketsRepository repository;

  FetchInitialPrivateMessages(this.repository);

  Future<List<MessageEntity>> call(String groupId) {
    return repository.fetchInitialMessages(groupId);
  }
}


// class AddChatUseCase{
//     final SocketsRepository repository;

//   AddChatUseCase(this.repository);
//     Future<Either<Failure, bool>> addChat({required String uid, required String receiverId}) async=> await repository.addChat(uid: uid, receiverId: receiverId) ;

// }