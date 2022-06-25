import 'package:bloc/bloc.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/strings/failures_strings.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

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

        emit(_foldFailureOrPosts(failureOrPosts));
      } else if (event is RefreshAllPostsEvent) {
        emit(PostsLoadingState());

        // you can use getAllPosts.call() instead
        final failureOrPosts = await getAllPosts();

        emit(_foldFailureOrPosts(failureOrPosts));
      }
    });
  }

  PostsState _foldFailureOrPosts(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => PostsFailedToLoadState(failMsg: _mapFailureToMsg(failure)),
        (posts) => PostsLoadedSuccessfullyState(posts: posts));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case DioFailure:
        return kServerFailureString;
      case CacheFailure:
        return kCacheFailureString;
      case NoInternetFailure:
        return kInternetFailureString;
      default:
        return kUndefinedFailureString;
    }
  }
}
