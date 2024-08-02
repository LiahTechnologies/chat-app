import 'package:get_it/get_it.dart';
import 'package:njadia/src/features/authentication/data/data_sources/user-data-source.dart';
import 'package:njadia/src/features/authentication/data/repositories/user-repository-impl.dart';
import 'package:njadia/src/features/authentication/domain/repositories/user-repository.dart';
import 'package:njadia/src/features/authentication/domain/usecases/user-usecase.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:njadia/src/features/create_group/domain/usecases/create-group-usecase.dart';
import 'package:njadia/src/features/create_group/presentation/blocs/group-bloc.dart';
import 'package:njadia/src/features/direct%20message/data/data_sources/chat-list-remote-data-source.dart';
import 'package:njadia/src/features/direct%20message/domain/usecase/chat_usecase.dart';
import 'package:njadia/src/features/direct%20message/presentation/bloc/private-socket-bloc.dart';
import 'package:njadia/src/features/direct%20message/presentation/bloc/socketServicer.dart';
import 'package:njadia/src/features/group_chat/data/data_source/group_chat_remote_data_source.dart';
import 'package:njadia/src/features/group_chat/data/repositories/group_repository_impl.dart';
import 'package:njadia/src/features/group_chat/domain/repositories/group_repository.dart';
import 'package:njadia/src/features/group_chat/domain/usecase/group_chat_usecase.dart';

import 'package:njadia/src/utils/theme/theme_bloc.dart';

import '../approve-tojoin-group/data/data-source/approve-remote-data-source.dart';
import '../approve-tojoin-group/data/repository/approve-repository-impl.dart';
import '../approve-tojoin-group/domain/repository/approval-repository.dart';
import '../approve-tojoin-group/domain/usecase/approve-usecase.dart';
import '../approve-tojoin-group/presentation/bloc/approval-bloc.dart';
import '../create_group/data/data_sources/group-remote-datasource.dart';
import '../create_group/data/repository/group-repositories-impl.dart';
import '../create_group/domain/repository/group-repository.dart';
import '../direct message/data/data_sources/socket-remote-datasource.dart';
import '../direct message/data/repository/chat_repo_imple.dart';
import '../direct message/data/repository/socket-repository.dart';
import '../direct message/domain/repository/chat_repository.dart';
import '../direct message/domain/usecase/socket-chat-usecase.dart';
import '../direct message/presentation/bloc/chat_list_bloc.dart';
import '../group_chat/data/data_source/group-socket-remote-data-source.dart';
import '../group_chat/data/data_source/group_list_remote_repository.dart';
import '../group_chat/data/repositories/group-socket-repositroy-impl.dart';
import '../group_chat/data/repositories/group_list_repository_impl.dart';
import '../group_chat/domain/repositories/group_list_repository.dart';
import '../group_chat/domain/usecase/group-socket-usecase.dart';
import '../group_chat/domain/usecase/group_chat_list_usecase_.dart';
import '../group_chat/presentation/bloc/group-socket-bloc.dart';
import '../group_chat/presentation/bloc/group_list_bloc.dart';
import '../payment/data/data-sources/get-group-member-data-source.dart';
import '../payment/data/repository/get-group-member-replository-impl.dart';
import '../payment/domain/repository/get-group-members-repository.dart';
import '../payment/domain/usecases/get-group-members-usecase.dart';
import '../payment/presentation/bloc/group-bloc.dart';
import '../search-groups/data/data-sources/search-group-remote-data-source.dart';
import '../search-groups/data/repositories/search-group-repository-impl.dart';
import '../search-groups/domain/repository/search-group-repository.dart';
import '../search-groups/domain/usecase/search-group-usecase.dart';
import '../search-groups/presentation/bloc/search-group-bloc.dart';

final locator = GetIt.instance;

void setUpLocator() {


// Sockets

//  locator.registerFactory(() => GroupSocketService());
 locator.registerFactory(() => PrivateSocketService());


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















/******GROUP CHATS******/

//  locator.registerFactory(() => GroupChatBloc(locator(), locator(),));
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






// PRIVATE CHAT




/******GROUP CHATS******/

 locator.registerFactory(() => ChatListBloc( chatListUsecase: locator(),));
  locator.registerFactory(() => PrivateSocketBloc(  connectSocket:  locator(), disconnectSocket:  locator(), sendMessage:  locator(), onMessage:  locator(), fetchInitialMessages:  locator(),));


//USECASES 
 locator.registerLazySingleton(() => ChatListUsecase( chatRepository: locator()));

 locator.registerLazySingleton(() => PrivateConnectSocket( locator()));
 locator.registerLazySingleton(() => DisconnectPrivateSocket( locator()));
 locator.registerLazySingleton(() => SendPrivateMessage( locator()));

 locator.registerLazySingleton(() => OnPrivateMessage( locator()));
 locator.registerLazySingleton(() => FetchInitialPrivateMessages( locator()));
  





//REPOSITORY
  
 locator.registerLazySingleton<ChatListRepository>(
      () => ChatListRepositoryImpl( privatChatListRemoteDataSource:  locator<PrivatChatListRemoteDataSource>(),));
 
 locator.registerLazySingleton<PrivateSocketsRepository>(
      () => PrivateSocketRepositoryImpl( locator<PrivateSocketRemoteDataSource>()));
 

//DATASOURCE

 locator
      .registerLazySingleton<PrivatChatListRemoteDataSource>(() => PrivatChatListRemoteDataSourceImpl(client: locator()));




 locator
      .registerLazySingleton<PrivateSocketRemoteDataSource>(() => PrivateSocketRemoteDataSourceImpl(locator()));









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







/// THIS IS THE SOCKET PART

// Bloc
 locator.registerFactory(() => SocketBloc(connectSocket: locator(),disconnectSocket:locator(),sendMessage: locator(),onMessage: locator(),fetchInitialMessages: locator(),addChatUseCase: locator()));
  // locator.registerFactory(() => ThemeBloc());


//USECASES 
 locator.registerLazySingleton(() => ConnectSocket( locator()));
 locator.registerLazySingleton(() => DisconnectSocket( locator()));
 locator.registerLazySingleton(() => SendMessage( locator()));

 locator.registerLazySingleton(() => OnMessage( locator()));
 locator.registerLazySingleton(() => FetchInitialMessages( locator()));
  locator.registerLazySingleton(() => AddChatUseCase( locator()));
  




//REPOSITORY
  
  
 locator.registerLazySingleton<SocketsRepository>(
      () => SocketRepositoryImpl( locator<SocketRemoteDataSource>()));




//DATASOURCE

 locator
      .registerLazySingleton<SocketRemoteDataSource>(() => SocketRemoteDataSourceImpl(locator()));




/******SEARCH GROUPS*****/


  

  // BLOC
  locator.registerFactory(() => SearchGroupBloc(locator()));
 

 
 




 //USECASE

    locator.registerLazySingleton(() => SearchGroupUsecase( searchGroupRepository: locator()));


  //Repository* 
  
  locator.registerLazySingleton<SearchGroupRepository>(
      () => searchGroupRepositoryImpl(searchGroupRemoteDataSource: locator<SearchGroupRemoteDataSource>()));

  

  


//DATASOURCES
  locator
      .registerLazySingleton<SearchGroupRemoteDataSource>(() => SearchGroupRemoteDataSourceImpl(client: locator()));






/* ***Group Members*/

 

  // BLOC
  locator.registerFactory(() => GroupMemberBloc(getGroupMemberUsecase: locator()));
 

 //USECASE

    locator.registerLazySingleton(() => GetGroupMemberUsecase( getGroupMemberRepository: locator()));


  //Repository* 
  
  locator.registerLazySingleton<GetGroupMemberRepository>(
      () => GetGroupMemberRepositoryImpl(getGroupMemberRemoteDataSource: locator<GetGroupMemberRemoteDataSource>()));

  

  


//DATASOURCES
  locator
      .registerLazySingleton<GetGroupMemberRemoteDataSource>(() => GetGroupMemberRemoteDataSourceImpl(client: locator()));




/****  Approve requst to Join group***/



  // BLOC
  locator.registerFactory(() => ApprovalBloc(approvalsUseCase: locator()));
 

 //USECASE

    locator.registerLazySingleton(() => ApprovalsUseCase( approvalRepository: locator()));


  //Repository* 
  
  locator.registerLazySingleton<ApprovalRepository>(
      () => ApproveToJoinRepositoryImpl(approveRemoteDataSource: locator<ApproveRemoteDataSource>()));


//DATASOURCES
  locator
      .registerLazySingleton<ApproveRemoteDataSource>(() => ApproveRemoteDataSourceImpl(client: locator()));


}
