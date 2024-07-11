import 'package:get_it/get_it.dart';
import 'package:njadia/src/core/chats%20functionality/socketServicer.dart';
import 'package:njadia/src/features/authentication/data/data_sources/user-data-source.dart';
import 'package:njadia/src/features/authentication/data/repositories/user-repository-impl.dart';
import 'package:njadia/src/features/authentication/domain/repositories/user-repository.dart';
import 'package:njadia/src/features/authentication/domain/usecases/user-usecase.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:njadia/src/features/create_group/domain/usecases/create-group-usecase.dart';
import 'package:njadia/src/features/create_group/presentation/blocs/group-bloc.dart';
import 'package:njadia/src/features/direct%20message/data/data_sources/chat_and_message_data_source.dart';
import 'package:njadia/src/features/direct%20message/data/repository/chat_message_repository.dart';
import 'package:njadia/src/features/direct%20message/domain/usecase/chat_usecase.dart';
import 'package:njadia/src/features/group_chat/data/datq_source/group_chat_remote_data_source.dart';
import 'package:njadia/src/features/group_chat/data/repositories/group_repository_impl.dart';
import 'package:njadia/src/features/group_chat/domain/repositories/group_repository.dart';
import 'package:njadia/src/features/group_chat/domain/usecase/group_chat_usecase.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_chat-bloc.dart';
import 'package:njadia/src/utils/theme/theme_bloc.dart';

import '../create_group/data/data_sources/group-remote-datasource.dart';
import '../create_group/data/repository/group-repositories-impl.dart';
import '../create_group/domain/repository/group-repository.dart';
import '../direct message/data/repository/chat_repo_imple.dart';
import '../direct message/domain/repository/chat_message_repository.dart';
import '../direct message/domain/repository/chat_repository.dart';
import '../direct message/domain/usecase/chat_message_usecase..dart';
import '../direct message/presentation/bloc/chat_message_bloc.dart';
import '../group_chat/data/datq_source/group_list_remote_repository.dart';
import '../group_chat/data/repositories/group_list_repository_impl.dart';
import '../group_chat/domain/repositories/group_list_repository.dart';
import '../group_chat/domain/usecase/group_chat_list_usecase_.dart';
import '../group_chat/presentation/bloc/group_list_bloc.dart';

final locator = GetIt.instance;

void setUpLocator() {

 locator.registerFactory(() => SocketService());

/******AUTHENTICATION*****/


  

  //BLOC
  locator.registerFactory(() => AuthBloc(userUsecase:locator()));
  locator.registerFactory(() => ThemeBloc());

 
 




 //USECASE

    locator.registerLazySingleton(() => UserUsecase(userRepository: locator()));


  //Repository* 
  
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDataSource: locator<UserRemoteDataSource>()));

  

  


//DATASOURCES
  locator
      .registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(client: locator()));




  // http.client
  locator.registerLazySingleton(() => http.Client());








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













/******GROUP CHATS******/

 locator.registerFactory(() => GroupChatBloc(locator(), locator(),));
 locator.registerFactory(() => GroupListBloc(groupListUsecase: locator()));


//USECASES 
 locator.registerLazySingleton(() => GroupChatUsecase(groupRepository: locator()));
 locator.registerLazySingleton(() => GroupListUsecase(groupListRepository: locator()));





//REPOSITORY
  
 locator.registerLazySingleton<GroupChatRepository>(
      () => GroupChatRepositoryImpl(groupChatRemoteDataSource: locator<GroupChatRemoteDataSource>()));

 locator.registerLazySingleton<GroupListRepository>(
      () => GroupListRepositoryImpl(groupListRemoteDataSource: locator<GroupListRemoteDataSource>()));


//DATASOURCE

 locator
      .registerLazySingleton<GroupChatRemoteDataSource>(() => GroupChatRemoteDataSourceImpl(client: locator()));


// locator
//       .registerLazySingleton<GroupListRemoteDataSource>(() => GroupListRemoteDataSourceImpl(client: locator()));



 locator
      .registerLazySingleton<GroupListRemoteDataSource>(() => GroupListRemoteDataSourceImpl(client: locator()));







/// CREATE GROUP


// Bloc
 locator.registerFactory(() => GroupBloc(groupUsecase: locator()));



//USECASES 
 locator.registerLazySingleton(() => GroupUsecase(groupRepository: locator()));




//REPOSITORY
  
 locator.registerLazySingleton<GroupRepository>(
      () => GroupRepositoryImpl(groupRemoteDataSoucrce: locator<GroupRemoteDataSoucrce>()));




//DATASOURCE

 locator
      .registerLazySingleton<GroupRemoteDataSoucrce>(() => GroupRemoteDataSourceImpl(client: locator()));

}
