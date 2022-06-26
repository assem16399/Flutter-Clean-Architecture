import '/core/network/network_info.dart';
import '/features/posts/data/data_sources/posts_local_data_source.dart';
import '/features/posts/data/data_sources/posts_remote_data_source.dart';
import '/features/posts/data/repos/post_repo.dart';
import '/features/posts/domain/repos/posts_repo.dart';
import '/features/posts/domain/usecases/add_new_post_usecase.dart';
import '/features/posts/domain/usecases/delete_post_usecase.dart';
import '/features/posts/domain/usecases/get_all_posts_usecase.dart';
import '/features/posts/domain/usecases/update_post_usecase.dart';
import '/features/posts/presentation/bloc/manage_post_bloc/manage_post_bloc.dart';
import '/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features - Posts

  //ToDo Register BLoCs

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(
    () => ManagePostBloc(
      addNewPost: sl(),
      updatePost: sl(),
      deletePost: sl(),
    ),
  );

  //ToDo Register UseCases

  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddNewPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

  //ToDo Register Repos

  sl.registerLazySingleton<PostsRepo>(() => PostsRepoImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //ToDo Register Data Sources

  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceImpl());
  sl.registerLazySingleton<PostsLocalDataSource>(
      () => PostsLocalDataSourceImpl());

  //ToDo Register Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //ToDo Register External Packages
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
