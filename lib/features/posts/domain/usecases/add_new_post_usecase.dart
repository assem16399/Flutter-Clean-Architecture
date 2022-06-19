import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';
import '../repos/posts_repo.dart';

class AddNewPostUseCase {
  final PostsRepo postsRepo;

  const AddNewPostUseCase(this.postsRepo);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postsRepo.addPost(post);
  }
}
