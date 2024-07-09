import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/data/datq_source/group_list_remote_repository.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/features/group_chat/domain/repositories/group_list_repository.dart';

class GroupListRepositoryImpl extends GroupListRepository {
  final GroupListRemoteDataSource groupListRemoteDataSource;

  GroupListRepositoryImpl({required this.groupListRemoteDataSource});
  @override
  Future<Either<Failure, bool>> deleteGroup(String groupId) {
    // TODO: implement deleteGroup
    throw UnimplementedError();
  }

  @override
  Stream<GroupChatEntity> fetchGroups(String groupId) {
    try {
      print("REACHING REPOSITORY IMPLEMENTATION");
      return groupListRemoteDataSource.fetchGroup(groupId: groupId);
    } on ServerExceptions {
      throw ServerFailure("Failed");
    }
  }
  
  @override
  Future<List<GroupChatEntity>> fetchchatgroups(String groupId) {
    // TODO: implement fetchchatgroups
    throw UnimplementedError();
  }
  
  
}
