import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/create_group/data/data_sources/group-remote-datasource.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';

import '../../../../core/common/errors/exceptions.dart';
import '../../domain/repository/group-repository.dart';

class GroupRepositoryImpl extends GroupRepository{
  final GroupRemoteDataSoucrce groupRemoteDataSoucrce;
  GroupRepositoryImpl({required this.groupRemoteDataSoucrce});

  @override
  Future<Either<Failure,bool>> createGroup(GroupEntity groupEntity) async {
     try {
      print("${groupEntity.groupName} THIS IS THE GROUP NAME");
       final result =  await groupRemoteDataSoucrce.createGroup(groupEntity);
      return Right(result);
     } on ServerExceptions {
       throw Left(ServerExceptions);
     }
  }
  
  @override
  Future<Either<Failure, String>> addAdmins({required String groupId,required String adminId})async {
    try {
       final result =  await groupRemoteDataSoucrce.addAdmins(groupId: groupId,adminId: adminId);
      return Right(result);
     } on ServerExceptions {
       throw Left(ServerExceptions);
     }
  }
  
  @override
  Future<Either<Failure, String>> addMembers({required String groupId,required String memberId})async {
    try {
       final result =  await groupRemoteDataSoucrce.addMembers(groupId: groupId,memberId: memberId);
      return Right(result);
     } on ServerExceptions {
       throw Left(ServerExceptions);
     }
  }
  
  @override
  Future<Either<Failure, String>> deleteAdmins({required String groupId}) {
    // TODO: implement deleteAdmins
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, String>> deleteMembers({required String groupId}) {
    // TODO: implement deleteMembers
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<String>>> groupAdmins({required String groupId}) {
    // TODO: implement groupAdmins
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<String>>> groupMembers({required String groupId}) {
    // TODO: implement groupMembers
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, String>> deleteGroup({required String groupId}) {
    // TODO: implement deleteGroup
    throw UnimplementedError();
  }

}