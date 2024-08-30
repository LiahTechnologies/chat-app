import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

import '../repositories/group_list_repository.dart';

class GroupListUsecase {

  final GroupListRepository groupListRepository;
  const GroupListUsecase({required this.groupListRepository});

  Stream<List<GroupChatEntity>> execute() =>groupListRepository.fetchGroups();
  
  Future<Either<Failure,List<GroupChatEntity>>> fetch() =>groupListRepository.fetchchatgroups();
  Future<Either<Failure,bool>> deleteGroup(List<String>groups) =>groupListRepository.deleteGroup(groups);
  Future<Either<Failure,MessageEntity>> fetchLastMessage({required String groupId}) =>groupListRepository.fetchLastGroupChatMessage(groupId: groupId);



  
}
