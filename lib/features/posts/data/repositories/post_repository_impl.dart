import 'package:posts_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this.remoteDataSource);

  final PostRemoteDataSource remoteDataSource;

  @override
  Future<List<Post>> getPosts() => remoteDataSource.getPosts();
}