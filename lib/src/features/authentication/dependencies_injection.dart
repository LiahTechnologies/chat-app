import 'package:get_it/get_it.dart';
import 'package:njadia/src/features/authentication/data/data_sources/user-data-source.dart';
import 'package:njadia/src/features/authentication/data/repositories/user-repository-impl.dart';
import 'package:njadia/src/features/authentication/domain/repositories/user-repository.dart';
import 'package:njadia/src/features/authentication/domain/usecases/user-usecase.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:njadia/src/features/direct%20message/data/data_sources/chat_and_message_data_source.dart';
import 'package:njadia/src/features/direct%20message/data/repository/chat_message_repository.dart';
import 'package:njadia/src/features/direct%20message/domain/usecase/chat_usecase.dart';
import 'package:njadia/src/utils/theme/theme_bloc.dart';

import '../direct message/data/repository/chat_repo_imple.dart';
import '../direct message/domain/repository/chat_message_repository.dart';
import '../direct message/domain/repository/chat_repository.dart';
import '../direct message/domain/usecase/chat_message_usecase..dart';
import '../direct message/presentation/bloc/chat_message_bloc.dart';

final locator = GetIt.instance;

void setUpLocator() {



/******AUTHENTICATION*****/


  // bloc
  locator.registerFactory(() => AuthBloc(userUsecase:locator()));
  locator.registerFactory(() => ThemeBloc());
  // usecase

    locator.registerLazySingleton(() => UserUsecase(userRepository: locator()));


  // Repository 
  
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDataSource: locator<UserRemoteDataSource>()));

  // Datasource

  locator
      .registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(client: locator()));


  // http.client
  locator.registerLazySingleton(() => http.Client());

  // locator.registerLazySingleton(()=>AuthController(usecase: locator<UserUsecase>()));


/******PRIVATE CHATS******/



locator.registerFactory(() => ChatMessageBloc(chatMessageUseCase:locator()));  
locator.registerFactory(() => ChatBloc(chatUsecase: locator()));  // usecase

locator.registerLazySingleton(() => ChatMessageUseCase(chatMessageRepository: locator()));
locator.registerLazySingleton(() => ChatUsecase(chatRepository: locator()));



  // Repository 
  
locator.registerLazySingleton<ChatMessageRepository>(
      () => ChatMessageRepositoryImpl(chatMessageRemoteDataSource: locator<ChatMessageRemoteDataSource>()));
locator.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(chatRemoteDataSource: locator<ChatRemoteDataSource>()));

  // Datasource

locator
      .registerLazySingleton<ChatMessageRemoteDataSource>(() => ChatMessageRemoteDataSourceImpl(client: locator()));
locator
      .registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(client: locator()));



}
