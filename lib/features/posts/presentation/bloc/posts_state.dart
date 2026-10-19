import 'package:posts_app/features/posts/domain/entities/post.dart';

class PostsState {
  const PostsState({
    this.isLoading = false,
    this.posts = const [],
    this.error,
  });

  final bool isLoading;
  final List<Post> posts;
  final String? error;
}