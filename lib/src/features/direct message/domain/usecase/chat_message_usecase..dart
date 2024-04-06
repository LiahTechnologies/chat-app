import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/failures.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/message.dart';
import 'package:njadia/src/features/direct%20message/domain/repository/chat_message_repository.dart';

class ChatMessageUseCase {
  final ChatMessageRepository chatMessageRepository;

  ChatMessageUseCase({required this.chatMessageRepository});

  Future<Either<Failure, ChatMessage>> execute(String chatRoomId) =>
      chatMessageRepository.fetchMessages(chatRoomId);

  Future<Either<Failure, bool>> deleteMessage(String chatId, ChatMessage message) =>
      chatMessageRepository.deleteMessages(message, chatId);

   Future<Either<Failure, bool>> sendMessage(String chatId, ChatMessage message) =>
      chatMessageRepository.sendMessages(message, chatId);

    
}
