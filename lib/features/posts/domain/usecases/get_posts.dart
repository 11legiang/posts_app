import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';

class GetPosts {
  GetPosts(this.repository);

  final PostRepository repository;

  Future<List<Post>> call() async {
    final posts = await repository.getPosts();
    return posts.where((p) => p.title.trim().isNotEmpty).toList();
  }
}