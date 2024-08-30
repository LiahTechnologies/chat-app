
import 'package:dartz/dartz.dart';

import '../../../../core/common/errors/failures.dart';

abstract class BallotRepository{
  Future<Either<Failure, bool>> generateBallots({required String groupId});
  Future<Either<Failure, List<String>>> fetchBallots({required String groupId,required String uid});
}