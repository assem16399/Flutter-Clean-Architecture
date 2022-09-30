import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/core/error/failures.dart';
import '/core/strings/process_success_strings.dart';
import '/features/posts/domain/entities/post.dart';
import '/features/posts/domain/usecases/delete_post_usecase.dart';
import '/features/posts/domain/usecases/update_post_usecase.dart';
import '../../../domain/usecases/add_new_post_usecase.dart';

part 'manage_post_event.dart';
part 'manage_post_state.dart';

class ManagePostBloc extends Bloc<ManagePostEvent, ManagePostState> {
  final AddNewPostUseCase addNewPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;

  ManagePostBloc({
    required this.addNewPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(ManagePostInitial()) {
    on<ManagePostEvent>((event, emit) async {
      emit(PostManagingProcessLoadingState());

      if (event is AddNewPostEvent) {
        // You can use addNewPost.call(event.addedPost) instead
        final failureOrUnit = await addNewPost(event.addedPost);
        emit(_getNextStateAfterEitherFolding(
            failureOrUnit, kPostAddedSuccessfullyString));
      } else if (event is EditExistingPostEvent) {
        // You can use updatePost.call(event.editedPost) instead
        final failureOrUnit = await updatePost(event.editedPost);
        emit(_getNextStateAfterEitherFolding(
            failureOrUnit, kPostUpdatedSuccessfullyString));
      } else if (event is DeleteExistingPostEvent) {
        // You can use deletePost.call(event.deletedPostId) instead
        final failureOrUnit = await deletePost(event.deletedPostId);
        emit(_getNextStateAfterEitherFolding(
            failureOrUnit, kPostDeletedSuccessfullyString));
      }
    });
  }

  // Method to emit the next happening state depending on the either value
  ManagePostState _getNextStateAfterEitherFolding(
      Either<Failure, Unit> either, String successMsg) {
    return either.fold(
        (failure) => PostManagingProcessFailedState(
            failMsg: _mapFailureToMessage(failure)),
        (unit) => PostManagingProcessSuccessState(successMsg: successMsg));
  }

  // Method to return the failure msg based on the failure type
  String _mapFailureToMessage(Failure failure) => failure.failureMsg;
}
