import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

import '../../../../core/common/errors/failures.dart';
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

  Future<void> call(String event, Function(dynamic) callback) async{
    repository.onMessage(event, (data)async{
      await callback(data);
    });
  }
}

class FetchInitialMessages {
  final SocketsRepository repository;

  FetchInitialMessages(this.repository);

  Future<List<MessageEntity>> call(String groupId) {
    return repository.fetchInitialMessages(groupId);
  }
}


class AddChatUseCase{
    final SocketsRepository repository;

  AddChatUseCase(this.repository);
    Future<Either<Failure, bool>> addChat({required String uid, required String receiverId}) async=> await repository.addChat(uid: uid, receiverId: receiverId) ;

}


// class GenerateBallotNumbersUsecase{
//     final SocketsRepository repository;

//   GenerateBallotNumbersUsecase(this.repository);
//   Future<Either<Failure, bool>> generateBallots({required String groupId}) async=> await repository.generateBallots(groupId: groupId);

// }