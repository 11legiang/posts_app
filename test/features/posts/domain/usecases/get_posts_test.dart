import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:posts_app/features/posts/domain/usecases/get_posts.dart';

// Kho giả: ký hợp đồng PostRepository nhưng không gọi internet
class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late MockPostRepository repository;
  late GetPosts useCase;

  setUp(() {
    repository = MockPostRepository();
    useCase = GetPosts(repository); // được đưa vào, như Laptop(nguon)
  });

  test('bỏ các bài có tiêu đề rỗng', () async {
    when(() => repository.getPosts()).thenAnswer(
      (_) async => [
        const Post(id: 1, title: 'Học Dart', body: 'a'),
        const Post(id: 2, title: '   ', body: 'b'),
      ],
    );

    final result = await useCase();

    expect(result.length, 1);
    expect(result.first.id, 1);
    verify(() => repository.getPosts()).called(1);
  });

  test('ném lỗi ra ngoài khi repository lỗi', () async {
    when(() => repository.getPosts())
        .thenAnswer((_) async => throw Exception('mất mạng'));

    await expectLater(useCase(), throwsA(isA<Exception>()));
  });
}