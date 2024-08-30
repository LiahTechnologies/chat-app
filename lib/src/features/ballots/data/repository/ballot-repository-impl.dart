

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/ballots/data/data-source/ballot-remote-datasource.dart';
import 'package:njadia/src/features/ballots/domain/repository/ballot-repository.dart';

class BallotRepositoryImpl extends BallotRepository{
  final BallotRemoteDataSource ballotRemoteDataSource;

  BallotRepositoryImpl({required this.ballotRemoteDataSource});
  @override
  Future<Either<Failure, List<String>>> fetchBallots({required String groupId, required String uid}) async{
    try {
      
      final result = await ballotRemoteDataSource.fetchBallots(groupId: groupId, uid: uid);
      return Right(result);
    } on ServerExceptions {
      throw Left(ServerFailure("Error"));
    }
  }

  @override
  Future<Either<Failure, bool>> generateBallots({required String groupId}) async{
    try {
      final result  = await ballotRemoteDataSource.generateBallots(groupId: groupId);
      return Right(result);
    } on ServerExceptions {
      throw Left(ServerFailure("Error"));
    }
  }

}