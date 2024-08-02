import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/payment/domain/entity/group-members.dart';

abstract class  ApprovalRepository{
  Future<Either<Failure,List<GroupMembers>>> getPendingRequest({required String groupId});
  Future<Either<Failure,bool>> approvePendingRequest({required String groupId, required String userId});
  Future<Either<Failure,bool>> rejectPendingRequest({required String groupId, required String userId});


} 