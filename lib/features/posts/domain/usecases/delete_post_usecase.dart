import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repos/posts_repo.dart';

class DeletePostUseCase {
  final PostsRepo postsRepo;

  const DeletePostUseCase(this.postsRepo);

  Future<Either<Failure, Unit>> call(int id) async {
    return await postsRepo.deletePost(id);
  }
}
