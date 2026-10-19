import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/domain/usecases/get_posts.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_event.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc(this._getPosts) : super(const PostsState()) {
    on<PostsRequested>(_onPostsRequested); // nhận phiếu PostsRequested thì làm hàm này
  }

  final GetPosts _getPosts;

  Future<void> _onPostsRequested(
    PostsRequested event,
    Emitter<PostsState> emit,
  ) async {
    emit(const PostsState(isLoading: true));
    try {
      final posts = await _getPosts();
      emit(PostsState(posts: posts));
    } catch (_) {
      emit(const PostsState(error: 'Không tải được dữ liệu'));
    }
  }
}