class ApprovalEvent{}


class OnFetchApprovals extends ApprovalEvent{
  final String groupId;
  

  OnFetchApprovals({required this.groupId});

}


class OnApprove extends ApprovalEvent{
   final String groupId;
  final String userId;

  OnApprove({required this.groupId, required this.userId});
}

class OnReject extends ApprovalEvent{
   final String groupId;
  final String userId;

  OnReject({required this.groupId, required this.userId});
}