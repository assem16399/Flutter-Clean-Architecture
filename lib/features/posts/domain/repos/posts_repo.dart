import 'package:clean_arch/features/posts/domain/entities/post.dart';

abstract class PostsRepo {
  Future<List<Post>> getAllPosts();

  Future<void> addPost();

  Future<void> updatePost(Post post);

  Future<void> deletePost(int id);
}
