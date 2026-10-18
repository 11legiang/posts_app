import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:posts_app/features/posts/data/models/post_model.dart';

class PostRemoteDataSource {
  PostRemoteDataSource(this.client);

  final http.Client client;

  Future<List<PostModel>> getPosts() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode != 200) {
      throw Exception('Server error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}