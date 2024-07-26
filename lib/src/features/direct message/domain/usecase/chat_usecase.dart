import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/user-profile.dart';

import '../entities/chat.dart';
import '../repository/chat_repository.dart';

class ChatListUsecase {
  final ChatListRepository chatRepository;
  ChatListUsecase({required this.chatRepository});

  Future<Either<Failure, List<UserProfile>>> execute() => chatRepository.fetchChats();

  // Future<Either<Failure, bool>> create(Chat chat) => chatRepository.createChats(chat);

  Future<Either<Failure, bool>> deleteChat(String receiverId) => chatRepository.deleteChats(receiverId);

}
