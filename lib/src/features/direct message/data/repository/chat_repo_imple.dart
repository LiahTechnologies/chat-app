import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';

import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/direct%20message/data/data_sources/chat-list-remote-data-source.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/user-profile.dart';

import '../../domain/entities/chat.dart';
import '../../domain/repository/chat_repository.dart';

class ChatListRepositoryImpl extends ChatListRepository {
  final  PrivatChatListRemoteDataSource privatChatListRemoteDataSource; 
  ChatListRepositoryImpl({required this.privatChatListRemoteDataSource});

  @override
  Future<Either<Failure, List<UserProfile>>> fetchChats() async {
    try {
      final response = await privatChatListRemoteDataSource.fetchChats();
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("something went wrong");
    }
  }

  // @override
  // Future<Either<Failure, bool>> createChats(Chat chat) async {
  //   try {
  //     final response = await privatChatListRemoteDataSource.createChats(chat);
  //     return Right(response);
  //   } on ServerExceptions {
  //     throw ServerFailure("something went wrong");
  //   }
  // }

  @override
  Future<Either<Failure, bool>> deleteChats(String receiverId)async {
    try {
      final response = await privatChatListRemoteDataSource.deleteChat(receiverId: receiverId);
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("something went wrong");
    }
  }
  
  
}
