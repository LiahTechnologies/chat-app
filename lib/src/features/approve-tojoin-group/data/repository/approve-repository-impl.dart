

import 'package:dartz/dartz.dart';

import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/approve-tojoin-group/data/data-source/approve-remote-data-source.dart';

import 'package:njadia/src/features/payment/domain/entity/group-members.dart';

import '../../domain/repository/approval-repository.dart';

class ApproveToJoinRepositoryImpl extends ApprovalRepository{

  ApproveRemoteDataSource approveRemoteDataSource;
  ApproveToJoinRepositoryImpl({required this.approveRemoteDataSource});


  @override
  Future<Either<Failure,bool>> approvePendingRequest({required String groupId, required String userId}) =>approveRemoteDataSource.approvePendingRequest(groupId: groupId, userId: userId);

  @override
  Future<Either<Failure, List<GroupMembers>>> getPendingRequest({required String groupId}) =>approveRemoteDataSource.getPendingRequest(groupId: groupId);

  
  
  @override
  Future<Either<Failure, bool>> rejectPendingRequest({required String groupId, required String userId}) =>approveRemoteDataSource.rejectPendingRequest(groupId: groupId, userId: userId);

}