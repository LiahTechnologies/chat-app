import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';

abstract  class GroupRepository{

  Future<Either<Failure,bool>> createGroup(GroupEntity groupEntity, File profilePic);

  Future<Either<Failure,List<String>>> groupAdmins({required String groupId});
  Future<Either<Failure,List<String>>> groupMembers({required String groupId});

  Future<Either<Failure,String>> addAdmins({required String groupId, required String adminId});
  Future<Either<Failure,String>> addMembers({required String groupId,required String memberId });

  Future<Either<Failure,String>> deleteAdmins({required String groupId});
  Future<Either<Failure,String>> deleteMembers({required String groupId});
  Future<Either<Failure,String>> deleteGroup({required String groupId});

}