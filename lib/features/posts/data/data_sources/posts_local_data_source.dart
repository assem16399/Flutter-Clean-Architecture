import 'dart:convert';

import 'package:clean_arch/core/network/local/cache_helper.dart';

import '/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../models/post_model.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPost();

  Future<Unit> cachePosts(List<PostModel> postModels);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) async {
    final postModelsRawData =
        postModels.map((postModel) => postModel.toJson()).toList();

    CacheHelper.setData(
        key: 'cachedPosts', value: jsonEncode(postModelsRawData));
    return unit;
  }

  @override
  Future<List<PostModel>> getCachedPost() async {
    final encodePostsJson = CacheHelper.getData(key: 'cachedPosts');
    if (encodePostsJson == null) throw CacheException();
    final postModelsRawData =
        jsonDecode(encodePostsJson) as List<Map<String, dynamic>>;
    return postModelsRawData
        .map((postModelRawData) => PostModel.fromJson(postModelRawData))
        .toList();
  }
}
