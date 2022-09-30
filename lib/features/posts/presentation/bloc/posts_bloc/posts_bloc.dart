import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/core/error/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetAllPostsEvent) {
        emit(PostsLoadingState());

        // you can use getAllPosts.call() instead
        final failureOrPosts = await getAllPosts();

        emit(_getNextStateAfterEitherFolding(failureOrPosts));
      } else if (event is RefreshAllPostsEvent) {
        emit(PostsLoadingState());

        // You can use getAllPosts.call() instead
        final failureOrPosts = await getAllPosts();

        emit(_getNextStateAfterEitherFolding(failureOrPosts));
      }
    });
  }

  // Method to emit the next happening state depending on the either value
  PostsState _getNextStateAfterEitherFolding(
      Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => PostsFailedToLoadState(failMsg: _mapFailureToMsg(failure)),
        (posts) => PostsLoadedSuccessfullyState(posts: posts));
  }

  // Method to return the failure msg based on the failure type
  String _mapFailureToMsg(Failure failure) => failure.failureMsg;
}
