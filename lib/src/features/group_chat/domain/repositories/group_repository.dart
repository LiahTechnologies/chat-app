import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/features/group_chat/domain/entities/message_entity.dart';

abstract class GroupRepository {

  Future<Either<Failure, bool>> sendMessage(
      MessageEntity messageEntity,String groupId);

  Future<Either<Failure, GroupChatEntity>> fetchMessage(String groupId);

  Future<Either<Failure,bool>> deleteMessage(MessageEntity messageEntity,String groupId);
}
