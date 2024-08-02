

import '../../../payment/domain/entity/group-members.dart';

class ApprovalState{}

class EmptyApprovals extends ApprovalState{}


class ApprovalsLoading extends ApprovalState{}

class ApprovalsLoadded extends ApprovalState{

  final List<GroupMembers> approvals;

  ApprovalsLoadded({required this.approvals});
}

class ApprovalError extends ApprovalState{
  final String error;

  ApprovalError({required this.error});
}

class ApprovedRequest extends ApprovalState{
  final bool status;

  ApprovedRequest({required this.status});
}

class RejectApproval extends ApprovalState{
  final bool status;

  RejectApproval({required this.status});
}