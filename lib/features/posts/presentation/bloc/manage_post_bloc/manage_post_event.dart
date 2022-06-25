part of 'manage_post_bloc.dart';

abstract class ManagePostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddNewPostEvent extends ManagePostEvent {
  final Post addedPost;

  AddNewPostEvent({required this.addedPost});
  @override
  List<Object?> get props => [addedPost];
}

class EditExistingPostEvent extends ManagePostEvent {
  final Post editedPost;

  EditExistingPostEvent({required this.editedPost});

  @override
  List<Object?> get props => [editedPost];
}

class DeleteExistingPostEvent extends ManagePostEvent {
  final int deletedPostId;

  DeleteExistingPostEvent({required this.deletedPostId});
  @override
  List<Object?> get props => [deletedPostId];
}
