import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_event.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_state.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách bài viết')),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.error!),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<PostsBloc>().add(PostsRequested()),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(post.title),
                subtitle: Text(post.body, maxLines: 2),
              );
            },
          );
        },
      ),
    );
  }
}