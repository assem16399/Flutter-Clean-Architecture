import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:clean_arch/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:clean_arch/features/posts/data/models/post_model.dart';
import 'package:clean_arch/features/posts/domain/entities/post.dart';
import 'package:clean_arch/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PostsRepoImpl implements PostsRepo {
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepoImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      return await _handleGettingDataFromServer();
    } else {
      return await _handleGettingDataFromCache();
    }
  }

  Future<Either<Failure, List<Post>>> _handleGettingDataFromServer() async {
    try {
      return Right(await _getPostsDataFromServer());
    } on DioError {
      return Left(DioFailure());
    }
  }

  Future<List<Post>> _getPostsDataFromServer() async {
    final remotePostModels = await remoteDataSource.getAllPosts();
    localDataSource.cachePosts(remotePostModels);
    return remotePostModels;
  }

  Future<Either<Failure, List<Post>>> _handleGettingDataFromCache() async {
    try {
      final localePostModels = await localDataSource.getCachedPost();
      return right(localePostModels);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _handlePostOperation(
        () => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _handlePostOperation(() => remoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _handlePostOperation(
        () => remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _handlePostOperation(
      Future<Unit> Function() postOperation) async {
    if (await networkInfo.isConnected) {
      try {
        await postOperation();
        return const Right(unit);
      } on DioError {
        return Left(DioFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
