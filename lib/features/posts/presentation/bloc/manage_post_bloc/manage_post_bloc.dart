import 'package:bloc/bloc.dart';
import 'package:clean_arch/core/strings/failures_strings.dart';
import 'package:clean_arch/core/strings/process_success_strings.dart';
import '/features/posts/domain/entities/post.dart';
import '/features/posts/domain/usecases/delete_post_usecase.dart';
import '/features/posts/domain/usecases/update_post_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
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
        final failureOrUnit = await addNewPost(event.addedPost);
        emit(_foldPostUseCase(failureOrUnit, kPostAddedSuccessfullyString));
      } else if (event is EditExistingPostEvent) {
        final failureOrUnit = await updatePost(event.editedPost);
        emit(_foldPostUseCase(failureOrUnit, kPostUpdatedSuccessfullyString));
      } else if (event is DeleteExistingPostEvent) {
        final failureOrUnit = await deletePost(event.deletedPostId);
        emit(_foldPostUseCase(failureOrUnit, kPostDeletedSuccessfullyString));
      }
    });
  }

  ManagePostState _foldPostUseCase(
      Either<Failure, Unit> either, String successMsg) {
    return either.fold(
        (failure) => PostManagingProcessFailedState(
            failMsg: _mapFailureToMessage(failure)),
        (unit) => PostManagingProcessSuccessState(successMsg: successMsg));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DioFailure:
        return kServerFailureString;

      case NoInternetFailure:
        return kInternetFailureString;

      default:
        return kUndefinedFailureString;
    }
  }
}
