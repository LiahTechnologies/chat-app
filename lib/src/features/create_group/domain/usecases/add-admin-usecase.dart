import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';
import 'package:njadia/src/features/create_group/domain/repository/group-repository.dart';

class AddGroupAdminUsecase {
 final GroupRepository groupRepository;

 AddGroupAdminUsecase({required this.groupRepository});

  Future<Either<Failure,void>> call({required String groupId, required String adminId})async{
    try {
     final result = await groupRepository.addAdmins(groupId: groupId,adminId: adminId);
     return Right(result);
    } on Failure {
      throw Left(ServerFailure("Error creating group"));
    }
  }

}