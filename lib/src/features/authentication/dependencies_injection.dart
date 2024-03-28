import 'package:get_it/get_it.dart';
import 'package:njadia/src/features/authentication/data/data_sources/user-data-source.dart';
import 'package:njadia/src/features/authentication/data/repositories/user-repository-impl.dart';
import 'package:njadia/src/features/authentication/domain/repositories/user-repository.dart';
import 'package:njadia/src/features/authentication/domain/usecases/user-usecase.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:njadia/src/utils/theme/theme_bloc.dart';

final locator = GetIt.instance;

void setUpLocator() {

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
}
