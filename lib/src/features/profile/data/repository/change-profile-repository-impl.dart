

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/profile/domain/repository/change-profile-repository.dart';

import '../remote-datasource/change-profile-remote-data-source.dart';

class changeProfileRepositoryImple extends ChangeProfileRepository{

 final ChangeProfileRemoteDatasource changeProfileRemoteDatasource;

  changeProfileRepositoryImple({required this.changeProfileRemoteDatasource});
  @override
  Future<Either<Failure, bool>> changeProfilePic({required File picture, required String uid}) async{
    try {
      final result = await changeProfileRemoteDatasource.changeProfilePic(picture: picture, uid: uid);
      return result;
    } on ServerExceptions {
       throw ServerFailure("Error");
    }
  }

}