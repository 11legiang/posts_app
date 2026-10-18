import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_state.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostsStatus.initial:
            case PostsStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PostsStatus.failure:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.errorMessage ?? 'Đã có lỗi'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.read<PostsCubit>().loadPosts(),
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              );
            case PostsStatus.success:
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(
                      post.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}