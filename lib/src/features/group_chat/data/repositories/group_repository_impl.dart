import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/exceptions.dart';
import 'package:njadia/src/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/data/datq_source/group_chat_remote_data_source.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/features/group_chat/domain/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/domain/repositories/group_repository.dart';

class GroupRepositoryImpl extends GroupRepository {
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
  Future<Either<Failure, GroupChatEntity>> fetchMessage(String groupId) async {
    try {
      final response =
          await groupChatRemoteDataSource.fetchMessage(groupId: groupId);
      return Right(response);
    } on ServerExceptions {
      throw Left(ServerFailure("Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, bool>> sendMessage(
      MessageEntity messageEntity, String groupId) async {
    try {
      final response = await groupChatRemoteDataSource.sendMessage(
          messageEntity: messageEntity, groupId: groupId);
      return Right(response);
    } on ServerExceptions {
      throw Left(ServerFailure("Something went wrong"));
    }
  }
}
