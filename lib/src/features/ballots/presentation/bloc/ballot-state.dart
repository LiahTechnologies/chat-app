

class BallotState{

}

class InitBallotState extends BallotState{}


class BallotsLoaded extends BallotState{
  final List<String> ballots;

  BallotsLoaded({required this.ballots});
}


class BallotError extends BallotState{}

class BallotGenerated extends BallotState{}