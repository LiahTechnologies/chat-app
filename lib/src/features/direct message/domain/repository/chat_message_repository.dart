import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/message.dart';

abstract class ChatMessageRepository {

  Future<Either<Failure, ChatMessage>> fetchMessages(String ChatRoomId);


  Future<Either<Failure, bool>> deleteMessages(ChatMessage message,String chatId);

  Future<Either<Failure, bool>> sendMessages(ChatMessage chatMessage, String chatId);


}
