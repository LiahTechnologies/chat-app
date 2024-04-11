import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

abstract class GroupRepository {

  Stream<Either<Failure, MessageEntity>> sendMessage(
      MessageEntity messageEntity,String groupId);

  Future<Either<Failure, GroupChatEntity>> fetchMessage(String groupId);

  Future<Either<Failure,bool>> deleteMessage(MessageEntity messageEntity,String groupId);
}
