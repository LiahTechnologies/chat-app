import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

import '../../../../core/common/errors/exceptions.dart';
import '../../../../core/common/errors/failures.dart';
import '../data_sources/socket-remote-datasource.dart';

abstract class PrivateSocketsRepository {
  void connect();
  void disconnect();
  void sendMessage(String event, dynamic data);
  void onMessage(String event, Function(dynamic) callback);
  Future<List<MessageEntity>> fetchInitialMessages(String groupId);
    Future<Either<Failure, bool>> addChat({required String uid, required String receiverId});

}

class PrivateSocketRepositoryImpl implements PrivateSocketsRepository {
  final PrivateSocketRemoteDataSource remoteDataSource;

  PrivateSocketRepositoryImpl(this.remoteDataSource);

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


  @override
  Future<Either<Failure, bool>> addChat({required String uid, required String receiverId})async {
   try {
    final result = await remoteDataSource.addChat(uid: uid, receiverId: receiverId);
    return Right(result);
     
   } on ServerExceptions {
      throw Left(ServerFailure("Error adding chat")); 
   }
  }
}
