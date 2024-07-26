import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/message.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/user-profile.dart';

import '../entities/chat.dart';

abstract class ChatListRepository {

  Future<Either<Failure, List<UserProfile>>> fetchChats();

  // Future<Either<Failure, bool>> createChats(Chat chat);

  Future<Either<Failure, bool>> deleteChats(String receiverId);

}