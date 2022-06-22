import 'dart:convert';

import '/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPost();

  Future<Unit> cachePosts(List<PostModel> postModels);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) async {
    final postModelsRawData =
        postModels.map((postModel) => postModel.toJson()).toList();

    await sharedPreferences.setString(
        'cachedPosts', jsonEncode(postModelsRawData));
    return unit;
  }

  @override
  Future<List<PostModel>> getCachedPost() async {
    final encodePostsJson = sharedPreferences.getString('cachedPosts');
    if (encodePostsJson == null) throw CacheException();
    final postModelsRawData =
        jsonDecode(encodePostsJson) as List<Map<String, dynamic>>;
    return postModelsRawData
        .map((postModelRawData) => PostModel.fromJson(postModelRawData))
        .toList();
  }
}
