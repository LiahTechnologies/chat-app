
import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';

import '../entity/group-members.dart';

abstract class GetGroupMemberRepository{
  Future<Either<Failure,List<GroupMembers>>> getMembers({required String groupId});
}