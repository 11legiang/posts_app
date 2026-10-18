import 'package:posts_app/features/posts/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}