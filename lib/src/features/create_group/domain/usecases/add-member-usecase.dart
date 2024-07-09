import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';
import 'package:njadia/src/features/create_group/domain/repository/group-repository.dart';

class AddGroupMemberUsecase {
 final GroupRepository groupRepository;

 AddGroupMemberUsecase({required this.groupRepository});

  Future<Either<Failure,void>> call({required String groupId, required String memberId})async{
    try {
     final result = await groupRepository.addMembers(groupId: groupId, memberId: memberId);
     return Right(result);
    } on Failure {
      throw Left(ServerFailure("Error creating group"));
    }
  }

}