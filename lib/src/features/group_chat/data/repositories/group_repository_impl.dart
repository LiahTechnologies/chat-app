import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/data/datq_source/group_chat_remote_data_source.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/domain/repositories/group_repository.dart';

class GroupRepositoryImpl extends GroupChatRepository {
  final GroupChatRemoteDataSource groupChatRemoteDataSource;

  GroupRepositoryImpl({required this.groupChatRemoteDataSource});

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

  @override
  Future<Either<Failure, MessageEntity>> fetchMessage(String groupId) async {
    try {
      final response =
          await groupChatRemoteDataSource.fetchMessage(groupId: groupId);
      return Right(response);
    } on ServerExceptions {
      throw Left(ServerFailure("Something went wrong"));
    }
  }



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
}
