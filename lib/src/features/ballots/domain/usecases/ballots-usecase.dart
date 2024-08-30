

import 'package:dartz/dartz.dart';
import 'package:njadia/src/features/ballots/domain/repository/ballot-repository.dart';

import '../../../../core/common/errors/failures.dart';

class BallotUsecase{

  final BallotRepository ballotRepository;

  BallotUsecase({required this.ballotRepository});
  Future<Either<Failure, bool>> generateBallots({required String groupId}) async=> await ballotRepository.generateBallots(groupId: groupId);
    Future<Either<Failure, List<String>>> fetchBallots({required String groupId, required String uid}) async=> await ballotRepository.fetchBallots(groupId: groupId,uid:uid );

}