import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

abstract class GroupChatRepository {

  // Stream<MessageEntity> sendMessage(
  //     MessageEntity messageEntity,String groupId);

   Future<Either<Failure,String>> sendMessage(
      MessageEntity messageEntity,String groupId);
      
  Future<Either<Failure, List<MessageEntity>>> fetchMessage(String groupId);

  Future<Either<Failure,bool>> deleteMessage(MessageEntity messageEntity,String groupId);
}
