import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/domain/usecases/get_posts.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this._getPosts) : super(const PostsState());

  final GetPosts _getPosts;

  Future<void> loadPosts() async {
    emit(const PostsState(status: PostsStatus.loading));
    try {
      final posts = await _getPosts();
      emit(PostsState(status: PostsStatus.success, posts: posts));
    } catch (_) {
      emit(
        const PostsState(
          status: PostsStatus.failure,
          errorMessage: 'Không tải được dữ liệu. Kiểm tra mạng và thử lại.',
        ),
      );
    }
  }
}