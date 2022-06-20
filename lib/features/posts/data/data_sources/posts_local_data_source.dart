import 'package:dartz/dartz.dart';

import '../models/post_model.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPost();

  Future<Unit> cachePosts(List<PostModel> postModels);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPost() {
    // TODO: implement getCachedPost
    throw UnimplementedError();
  }
}
