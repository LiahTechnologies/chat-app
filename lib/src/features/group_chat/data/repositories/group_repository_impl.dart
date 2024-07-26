import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/data/data_source/group_chat_remote_data_source.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/domain/repositories/group_repository.dart';

import '../model/group_chat_model.dart';

class GroupChatRepositoryImpl extends GroupChatRepository {
  final GroupChatRemoteDataSource groupChatRemoteDataSource;

  GroupChatRepositoryImpl({required this.groupChatRemoteDataSource});

  @override
  Future<Either<Failure, bool>> deleteMessage(
      MessageEntity messageEntity, String groupId) async {
    try {
      final response = await groupChatRemoteDataSource.deleteMessage(
          groupId: groupId, messageEntity: messageEntity);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure("Something went wrong"));
    }
  }



  // @override
  // Future<Either<Failure, List<MessageEntity>>> fetchMessage(String groupId) async {
    // try {

    //   final response =
    //       await groupChatRemoteDataSource.fetchMessage(groupId: groupId);
    //   return Right(response);

    // } on ServerExceptions {

    //   throw Left(ServerFailure("Something went wrong"));

    // }
  // }



/*

  @override
  Stream<MessageEntity> sendMessage(
      MessageEntity messageEntity, String groupId) {
    try {
      return groupChatRemoteDataSource.sendMessage(
          messageEntity: messageEntity, channel_id: groupId); 
    } on ServerExceptions {
      throw ServerExceptions();
    }
  }

*/

   @override
  Future<Either<Failure,List<GroupChatModel>>> sendMessage(
      MessageEntity messageEntity, String groupId) async{
    try {
      final result = await groupChatRemoteDataSource.sendMessage(
          messageEntity: messageEntity,groupId: groupId); 

        return Right(result);
    } on ServerExceptions {
      throw ServerExceptions();
    }
  }
  
  @override
  Future<Either<Failure, List<MessageEntity>>> fetchMessage(String groupId) async {
    try {

      final response =
          await groupChatRemoteDataSource.fetchMessage(groupId: groupId);
      return Right(response);

    } on ServerExceptions {

      throw Left(ServerFailure("Something went wrong"));

    }
  }
  
  @override
  Future<Either<Failure, bool>> addChat({required String uid, required String receiverId})async {
   try {
    final result = await groupChatRemoteDataSource.addChat(uid: uid, receiverId: receiverId);
    return Right(result);
     
   } on ServerExceptions {
      throw Left(ServerFailure("Error adding chat")); 
   }
  }
}
