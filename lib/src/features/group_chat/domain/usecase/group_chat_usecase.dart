import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/domain/repositories/group_repository.dart';

class GroupChatUsecase {
  final GroupChatRepository groupRepository;
  const GroupChatUsecase({required this.groupRepository});

  Future<Either<Failure, List<MessageEntity>>> sendMessage(MessageEntity message,String groupId) async =>
      await groupRepository.sendMessage(message,groupId);

  Future<Either<Failure, List<MessageEntity>>> fetchMessage(String groupId) async =>
      await groupRepository.fetchMessage(groupId);

  // Stream< MessageEntity> sendMessage(
  //         MessageEntity messageEntity, String groupId)  =>
  //      groupRepository.sendMessage(messageEntity,groupId);

  Future<Either<Failure, bool>> deleteMessage(
          MessageEntity messageEntity, String groupId) async =>
      await groupRepository.deleteMessage(messageEntity, groupId);

  Future<Either<Failure, bool>> addChat({required String uid, required String receiverId}) async=> await groupRepository.addChat(uid: uid, receiverId: receiverId) ;
}
