import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';

import 'message.dart';

class Chat {
  final String chatId;
  final String userId;
  final String profilePic;
  Chat({
    required this.chatId,
    required this.userId,
    required this.profilePic
  });
}
