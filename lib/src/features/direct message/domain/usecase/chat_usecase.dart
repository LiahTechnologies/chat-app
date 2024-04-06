import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/failures.dart';

import '../entities/chat.dart';
import '../repository/chat_message_repository.dart';
import '../repository/chat_repository.dart';

class ChatUsecase {
  final ChatRepository chatRepository;
  ChatUsecase({required this.chatRepository});

  Future<Either<Failure, Chat>> execute(String chatId) => chatRepository.fetchChats(chatId);

  Future<Either<Failure, bool>> create(Chat chat) => chatRepository.createChats(chat);

  Future<Either<Failure, bool>> deleteChat(String chatId) => chatRepository.deleteChats(chatId);

}
