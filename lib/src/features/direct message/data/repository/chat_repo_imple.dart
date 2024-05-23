import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';

import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/direct%20message/data/data_sources/chat_and_message_data_source.dart';

import '../../domain/entities/chat.dart';
import '../../domain/repository/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepositoryImpl({required this.chatRemoteDataSource});

  @override
  Future<Either<Failure, Chat>> fetchChats(String chatId) async {
    try {
      final response = await chatRemoteDataSource.fetchChats(chatId);
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("something went wrong");
    }
  }

  @override
  Future<Either<Failure, bool>> createChats(Chat chat) async {
    try {
      final response = await chatRemoteDataSource.createChats(chat);
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("something went wrong");
    }
  }

  @override
  Future<Either<Failure, bool>> deleteChats(String chatId)async {
    try {
      final response = await chatRemoteDataSource.deleteChats(chatId);
      return Right(response);
    } on ServerExceptions {
      throw ServerFailure("something went wrong");
    }
  }
}
