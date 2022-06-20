import 'package:clean_arch/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel editedPostModel);
  Future<Unit> addPost(PostModel newPostModel);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  @override
  Future<Unit> addPost(PostModel newPostModel) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost(int deletedPostId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel editedPostModel) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
