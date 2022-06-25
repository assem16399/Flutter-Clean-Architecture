part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedSuccessfullyState extends PostsState {
  final List<Post> posts;

  PostsLoadedSuccessfullyState({required this.posts});
  @override
  List<Object?> get props => [];
}

class PostsFailedToLoadState extends PostsState {
  final String failMsg;

  PostsFailedToLoadState({required this.failMsg});
}
