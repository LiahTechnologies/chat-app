import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';
import 'package:njadia/src/features/create_group/domain/repository/group-repository.dart';

class DeleteGroupUsecase {
 final GroupRepository groupRepository;

 DeleteGroupUsecase({required this.groupRepository});

  Future<Either<Failure,void>> call(String groupId)async{
    try {
     final result = await groupRepository.deleteGroup(groupId: groupId);
     return Right(result);
    } on Failure {
      throw Left(ServerFailure("Error creating group"));
    }
  }

}