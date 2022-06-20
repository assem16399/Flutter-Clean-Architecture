import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:clean_arch/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:clean_arch/features/posts/domain/entities/post.dart';
import 'package:clean_arch/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

class PostsRepoImpl implements PostsRepo {
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource;

  PostsRepoImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
