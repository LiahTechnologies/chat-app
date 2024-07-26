

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/search-groups/domain/repository/search-group-repository.dart';

import '../../../group_chat/domain/entities/group_chat_entity.dart';

class SearchGroupUsecase{

  final SearchGroupRepository searchGroupRepository;

  SearchGroupUsecase({required this.searchGroupRepository });


  Future<Either<Failure,GroupChatEntity>> call(String groupName )=>searchGroupRepository.findGroup(groupName: groupName);
  Future<Either<bool,bool>> hasUserJoined(String groupId)=>searchGroupRepository.hasUserJoined(groupId: groupId);
  Future<Either<Failure,bool>>joinGroup({required String groupId, required String uid})=>searchGroupRepository.joinedGroup(groupId: groupId, uid: uid);

}