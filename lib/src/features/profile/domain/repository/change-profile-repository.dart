

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';

abstract class ChangeProfileRepository{

  Future<Either<Failure, bool>> changeProfilePic({required File picture, required String uid});
}