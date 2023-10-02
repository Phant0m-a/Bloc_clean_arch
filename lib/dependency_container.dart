import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:inbloc_clean/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:inbloc_clean/features/auth/domain/usecases/get_catched_user_usecase.dart';
import 'package:inbloc_clean/features/auth/domain/usecases/logout_user_usecase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/globals.dart';
import 'core/utils/network_info/network_info.dart';
import 'features/auth/data/data_sources/auth_remote_datasource.dart';
import 'features/auth/data/repository/auth_repo_imp.dart';
import 'features/auth/domain/repository/auth_repostory.dart';
import 'features/auth/domain/usecases/cache_user_usecase.dart';
import 'features/auth/domain/usecases/login_user_usecase.dart';
import 'features/auth/presentation/manager/bloc/authentication_bloc.dart';

Future<void> init() async {
  GetIt.instance.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await GetIt.instance.isReady<SharedPreferences>();
  //bloc
  sl.registerFactory(() => AuthenticationBloc(
      getUser: sl(), cacheUser: sl(), login: sl(), logout: sl()));

  /// UseCases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => GetCachedUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => CacheUserUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUserUsecase(sl()));

  //remote data sources
  sl.registerLazySingleton(() => SharedPreferences.getInstance());

  /// Repository
  ///   // data layer: Repo Implementation
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImp(
      localDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));

  // Remote Data Src
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(dio: sl()));

  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSrcImpl(sl()));

  /// External
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
