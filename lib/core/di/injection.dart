import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:posts_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:posts_app/features/posts/data/repositories/post_repository_impl.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:posts_app/features/posts/domain/usecases/get_posts.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt
    ..registerLazySingleton<http.Client>(() => http.Client())
    ..registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSource(getIt<http.Client>()),
    )
    ..registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(getIt<PostRemoteDataSource>()),
    )
    ..registerLazySingleton<GetPosts>(
      () => GetPosts(getIt<PostRepository>()),
    )
    ..registerFactory<PostsCubit>(() => PostsCubit(getIt<GetPosts>()));
}