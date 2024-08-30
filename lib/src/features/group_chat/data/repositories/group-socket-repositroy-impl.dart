import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

import '../../../../core/common/errors/exceptions.dart';
import '../../../../core/common/errors/failures.dart';
import '../data_source/group-socket-remote-data-source.dart';

abstract class SocketsRepository {
  void connect();
  void disconnect();
  void sendMessage(String event, dynamic data);
  Future<void> onMessage(String event, Function(dynamic) callback);
  Future<List<MessageEntity>> fetchInitialMessages(String groupId);
    Future<Either<Failure, bool>> addChat({required String uid, required String receiverId});
      Future<Either<Failure, bool>> generateBallots({required String groupId});
      Future<Either<Failure, List<String>>> fetchBallots({required String groupId,required String uid});


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
  Future<void> onMessage(String event, Function(dynamic) callback) async {
    remoteDataSource.onMessage(event, (data)async{
      await callback(data);
    });
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
  

  @override
  Future<Either<Failure, bool>> generateBallots({required String groupId}) async{
    try {
      final result = await remoteDataSource.generateBallots(groupId: groupId);
      return Right(result);
      
    } on ServerExceptions {
        throw Left(ServerFailure(""));
    }
  }
  
  @override
  Future<Either<Failure, List<String>>> fetchBallots({required String groupId, required String uid})async {
    try {
      final result = await remoteDataSource.fetchBallots(groupId: groupId, uid: uid);
      return Right(result);
      
    }on ServerExceptions {
        throw Left(ServerFailure(""));
    }
  }
  
  
}
