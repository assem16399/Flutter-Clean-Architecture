import 'package:clean_arch/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class GetAllPostsUseCase {
  final PostsRepo postsRepo;

  const GetAllPostsUseCase(this.postsRepo);

  Future<Either<Failure, List<Post>>> call() async {
    return await postsRepo.getAllPosts();
  }
}
