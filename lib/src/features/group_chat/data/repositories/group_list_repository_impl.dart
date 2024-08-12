import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/data/data_source/group_list_remote_repository.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/features/group_chat/domain/repositories/group_list_repository.dart';

class GroupListRepositoryImpl extends GroupListRepository {
  final GroupListRemoteDataSource groupListRemoteDataSource;

  GroupListRepositoryImpl({required this.groupListRemoteDataSource});
  @override
  Future<Either<Failure, bool>> deleteGroup(List<String> groups) async{
    try {
      final reuslt = await groupListRemoteDataSource.deleteGroups(groups: groups);
      return Right(reuslt);
    } catch (e) {
      throw Left(ServerFailure("Error deleting groups"));
    }
  }




  @override
  Stream<List<GroupChatEntity>> fetchGroups() {
    try {
      print("REACHING REPOSITORY IMPLEMENTATION");
      return groupListRemoteDataSource.fetchGroup();
    } on ServerExceptions {
      throw ServerFailure("Failed");
    }
  }
  



  @override
  Future<Either<Failure,List<GroupChatEntity>>> fetchchatgroups() async{
    try {
       final result = await groupListRemoteDataSource.fetchGroups();

       return Right(result);

    } on ServerExceptions{
      throw Left(ServerFailure("Error fetching groups"));
    }}
  
  
}
