import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';

import 'message.dart';

class Chat {
  final String chatId;
  // final String userId;
  final String profilePic;
  final String userName;
  final String time;
  final bool isGroup;
  final String lastMessage;
  Chat({
    required this.chatId,
    // required this.userId,
    required this.profilePic,
    required this.time,
    required this.userName,
    required this.isGroup, 
    required this. lastMessage,
    
  });
}
