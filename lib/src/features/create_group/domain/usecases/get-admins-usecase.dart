import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';
import 'package:njadia/src/features/create_group/domain/repository/group-repository.dart';

class GetGroupAdminUsecase {
 final GroupRepository groupRepository;

 GetGroupAdminUsecase({required this.groupRepository});

  // Future<Either<Failure,List<UserEntity>>> call(String groupId)async{
  //   try {
  //    final result = await groupRepository.groupAdmins(groupId: groupId);
  //   //  return result;
  //   } on Failure {
  //     throw Left(ServerFailure("Error creating group"));
  //   }
  // }

}