import 'package:dartz/dartz.dart';
import 'package:njadia/src/common/errors/exceptions.dart';

import 'package:njadia/src/common/errors/failures.dart';
import 'package:njadia/src/features/direct%20message/data/data_sources/chat_and_message_data_source.dart';

import 'package:njadia/src/features/direct%20message/domain/entities/message.dart';

import '../../domain/repository/chat_message_repository.dart';



class ChatMessageRepositoryImpl extends ChatMessageRepository {
  final ChatMessageRemoteDataSource chatMessageRemoteDataSource;

  ChatMessageRepositoryImpl({required this.chatMessageRemoteDataSource});

  @override
  Future<Either<Failure, bool>> deleteMessages(
      ChatMessage message, String chatId) async {
    try {
      final response =
          await chatMessageRemoteDataSource.deleteMessage(message, chatId);
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("something went wrong");
    }
  }

  
  
  @override
  Future<Either<Failure, ChatMessage>> fetchMessages(String chatRoomId) async{
   try {
      final response =
          await chatMessageRemoteDataSource.fetchMessages(chatRoomId);
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("something went wrong");
    }
  }
  
  
  @override
  Future<Either<Failure, bool>> sendMessages(ChatMessage chatMessage,String chatId) async{
    try {
      final response =
          await chatMessageRemoteDataSource.sendMessage(chatMessage,chatId);
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("something went wrong");
    }
  }

 
}
