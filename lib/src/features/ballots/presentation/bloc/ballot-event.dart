

class BallotEvent{

}


class OnGenerateBallots extends BallotEvent{
  final String groupId;

  OnGenerateBallots({required this.groupId});

}


class OnFetchBallots extends BallotEvent{
  final String groupId;
  final String uid;

  OnFetchBallots({required this.groupId, required this.uid});
}