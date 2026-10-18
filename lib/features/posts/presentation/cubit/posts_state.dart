import 'package:posts_app/features/posts/domain/entities/post.dart';

enum PostsStatus { initial, loading, success, failure }

class PostsState {
  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.errorMessage,
  });

  final PostsStatus status;
  final List<Post> posts;
  final String? errorMessage;
}