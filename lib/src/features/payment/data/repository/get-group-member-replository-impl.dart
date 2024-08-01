import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:njadia/src/features/payment/data/data-sources/get-group-member-data-source.dart';
import 'package:njadia/src/features/payment/domain/repository/get-group-members-repository.dart';

import '../../domain/entity/group-members.dart';

class GetGroupMemberRepositoryImpl extends GetGroupMemberRepository{

  final  GetGroupMemberRemoteDataSource getGroupMemberRemoteDataSource;
   GetGroupMemberRepositoryImpl({required this.getGroupMemberRemoteDataSource});
  @override
  Future<Either<Failure, List<GroupMembers>>> getMembers({required String groupId}) =>getGroupMemberRemoteDataSource.getGroupMember(groupId: groupId);
}