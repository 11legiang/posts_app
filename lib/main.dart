import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/di/injection.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_event.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (_) => getIt<PostsBloc>()..add(PostsRequested()),
        ),
      ],
      child: const MaterialApp(title: 'Posts', home: PostsPage()),
    );
  }
}