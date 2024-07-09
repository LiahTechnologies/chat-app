import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/message.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

import '../entities/chat.dart';

abstract class ChatRepository {

  Future<Either<Failure, List<Chat>>> fetchChats(String ChatId);

  Future<Either<Failure, bool>> createChats(Chat chat);

  Future<Either<Failure, bool>> deleteChats(String chatId);

}