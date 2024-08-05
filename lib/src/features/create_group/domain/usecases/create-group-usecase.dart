import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';
import 'package:njadia/src/features/create_group/domain/repository/group-repository.dart';

class GroupUsecase {
 final GroupRepository groupRepository;

 GroupUsecase({required this.groupRepository});

  Future<Either<Failure,bool>> execute(GroupEntity groupEntity)async{
    try {
     final result = await groupRepository.createGroup(groupEntity);
     return result;
    } on Failure {
      throw Left(ServerFailure("Error creating group"));
    }
  }

}