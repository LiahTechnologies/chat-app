import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';
import 'package:njadia/src/features/create_group/domain/repository/group-repository.dart';

class DeleteGroupAdminUsecase {
 final GroupRepository groupRepository;

 DeleteGroupAdminUsecase({required this.groupRepository});

  Future<Either<Failure,void>> call(String groupId)async{
    try {
     final result = await groupRepository.deleteAdmins(groupId: groupId);
     return Right(result);
    } on Failure {
      throw Left(ServerFailure("Error creating group"));
    }
  }

}