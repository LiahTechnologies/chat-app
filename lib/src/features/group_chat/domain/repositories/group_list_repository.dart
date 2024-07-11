
import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

abstract class GroupListRepository {

  Stream<GroupChatEntity> fetchGroups(String groupId);
  Future<Either<Failure,List<GroupChatEntity>>> fetchchatgroups();

  Future<Either<Failure,bool>> deleteGroup(String groupId);
}
