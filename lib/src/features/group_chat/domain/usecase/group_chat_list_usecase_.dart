import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/domain/repositories/group_repository.dart';

import '../repositories/group_list_repository.dart';

class GroupListUsecase {
  final GroupListRepository groupListRepository;
  const GroupListUsecase({required this.groupListRepository});

  Stream<GroupEntity> execute(String groupId) =>groupListRepository.fetchGroups(groupId);
  
      Future<List<GroupEntity>> fetch(String groupId) =>groupListRepository.fetchchatgroups(groupId);

  
}
