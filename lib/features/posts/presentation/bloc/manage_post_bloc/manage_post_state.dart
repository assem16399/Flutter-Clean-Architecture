part of 'manage_post_bloc.dart';

abstract class ManagePostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ManagePostInitial extends ManagePostState {}

class PostManagingProcessLoadingState extends ManagePostState {}

class PostManagingProcessFailedState extends ManagePostState {
  final String failMsg;

  PostManagingProcessFailedState({required this.failMsg});

  @override
  List<Object?> get props => [failMsg];
}

class PostManagingProcessSuccessState extends ManagePostState {
  final String successMsg;

  PostManagingProcessSuccessState({required this.successMsg});

  @override
  List<Object?> get props => [successMsg];
}
