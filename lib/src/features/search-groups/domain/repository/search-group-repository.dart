import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';

import '../../../group_chat/domain/entities/group_chat_entity.dart';

abstract class SearchGroupRepository{

  Future<Either<Failure,GroupChatEntity>>findGroup({required String groupName});
  Future <Either<bool,bool>> hasUserJoined({required String groupId});
  Future<Either<Failure, bool>> joinedGroup({required String groupId, required String uid});
}