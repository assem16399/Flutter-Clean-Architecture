import 'package:clean_arch/core/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';

import '/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

const kPostsEndpoint = '/posts';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel editedPostModel);
  Future<Unit> addPost(PostModel newPostModel);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await DioHelper.getRequest(path: kPostsEndpoint);
    if (_canBeParsed(response)) {
      return _parsePostModelsJson(response.data);
    }
    return [];
  }

  bool _canBeParsed(Response response) {
    return response.data is List<Map<String, dynamic>> &&
        response.statusCode == 200;
  }

  List<PostModel> _parsePostModelsJson(List<Map<String, dynamic>> rawData) {
    final postModelsRawData = rawData;
    return postModelsRawData
        .map((postModelRawData) => PostModel.fromJson(postModelRawData))
        .toList();
  }

  @override
  Future<Unit> addPost(PostModel newPostModel) async {
    final data = newPostModel.toJson();
    await DioHelper.postRequest(path: kPostsEndpoint, data: data);
    return unit;
  }

  @override
  Future<Unit> deletePost(int deletedPostId) async {
    await DioHelper.deleteRequest(path: '$kPostsEndpoint/$deletedPostId');
    return unit;
  }

  @override
  Future<Unit> updatePost(PostModel updatedPostModel) async {
    final updatedPostId = updatedPostModel.id;
    final updatedPostModelJson = updatedPostModel.toJson();
    await DioHelper.patchRequest(
      path: '$kPostsEndpoint/$updatedPostId',
      data: updatedPostModelJson,
    );
    return unit;
  }
}
