import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/domain/repositories/group_repository.dart';

class GroupChatUsecase {
  final GroupRepository groupRepository;
  const GroupChatUsecase({required this.groupRepository});

  Future<Either<Failure, GroupChatEntity>> execute(String groupId) async =>
      await groupRepository.fetchMessage(groupId);

  Future<Either<Failure, MessageEntity>> sendMessage(
          MessageEntity messageEntity, String groupId) async =>
      await groupRepository.sendMessage(messageEntity,groupId);

  Future<Either<Failure, bool>> deleteMessage(
          MessageEntity messageEntity, String groupId) async =>
      await groupRepository.deleteMessage(messageEntity, groupId);
}
