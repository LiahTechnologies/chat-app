

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';

import '../repository/change-profile-repository.dart';

class ChangeProfileUsecase{
  final ChangeProfileRepository changeProfileRepository;

  ChangeProfileUsecase({required this.changeProfileRepository});


  Future<Either<Failure,bool>> changeProfilePic({required File profilePic, required String uid})=>changeProfileRepository.changeProfilePic(picture: profilePic, uid: uid);
}