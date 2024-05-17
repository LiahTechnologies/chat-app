
import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

abstract class GroupListRepository {

  Stream<GroupEntity> fetchGroups(String groupId);
  Future<List<GroupEntity>> fetchchatgroups(String groupId);

  Future<Either<Failure,bool>> deleteGroup(String groupId);
}
