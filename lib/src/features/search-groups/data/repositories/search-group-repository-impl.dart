

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';
import 'package:njadia/src/features/search-groups/data/data-sources/search-group-remote-data-source.dart';
import 'package:njadia/src/features/search-groups/domain/repository/search-group-repository.dart';

class searchGroupRepositoryImpl extends SearchGroupRepository{

final SearchGroupRemoteDataSource searchGroupRemoteDataSource;

  searchGroupRepositoryImpl({required this.searchGroupRemoteDataSource});



  @override
  Future<Either<Failure, GroupChatEntity>> findGroup({required String groupName}) async {

    try {
      
      final result  = await  searchGroupRemoteDataSource.findGroup(groupName: groupName);
        return Right(result);


    } on ServerExceptions {
      throw  ServerFailure("Error Fetching data");
    }
   
  }
  
  @override
  Future<Either<bool, bool>> hasUserJoined({required String groupId}) async {
    try {
      final result = await searchGroupRemoteDataSource.hasUserJoined(groupId: groupId);
      return Right(result);
    } on ServerExceptions {
      throw  ServerFailure("Error Fetching data");
    }
  }
  
  @override
  Future<Either<Failure, bool>> joinedGroup({required String groupId, required String uid}) async {
   try {
     final result = await searchGroupRemoteDataSource.joinGroup(groupId: groupId, uid: uid);
     return Right(result);
   } on ServerExceptions {
     throw Left(ServerFailure("Error adding user"));
   }
  }

}