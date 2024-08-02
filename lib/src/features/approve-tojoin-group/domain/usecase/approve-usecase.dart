

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/approve-tojoin-group/domain/repository/approval-repository.dart';

import '../../../payment/domain/entity/group-members.dart';

class ApprovalsUseCase{
  ApprovalRepository approvalRepository;

  ApprovalsUseCase({required this.approvalRepository});

  Future<Either<Failure,List<GroupMembers>>> getPendingRequest({required String groupId})=>approvalRepository.getPendingRequest(groupId: groupId);
  Future<Either<Failure,bool>> approvePendingRequest({required String groupId,required String userId})=>approvalRepository.approvePendingRequest(groupId: groupId, userId: userId);
  Future<Either<Failure,bool>> rejectPendingRequest({required String groupId,required String userId})=>approvalRepository.rejectPendingRequest(groupId: groupId, userId: userId);


}