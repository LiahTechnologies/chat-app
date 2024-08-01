
import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/payment/domain/entity/group-members.dart';
import 'package:njadia/src/features/payment/domain/repository/get-group-members-repository.dart';

class GetGroupMemberUsecase{
  final GetGroupMemberRepository getGroupMemberRepository;

  GetGroupMemberUsecase({required this.getGroupMemberRepository});
   
  Future<Either<Failure,List<GroupMembers>>> call({required String groupId})=>getGroupMemberRepository.getMembers(groupId: groupId);
}