import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/comment.dart';
import 'package:rokhshare/feature/media/data/repositories/media_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';
import 'package:rokhshare/utils/page_response.dart';

part 'comments_items_state.dart';

class CommentsItemsCubit extends Cubit<CommentsItemsState> {
  final MediaRepository repository;
  final int mediaId;

  CommentsItemsCubit(
      {required this.repository,
      required this.mediaId,
      required int total,
      required List<Comment> comments})
      : super(CommentsItemsState.init(comments, total));

  Future<void> getComments({int page = 1, bool retry = false}) async {
    if ((state.nextPage > state.lastPage) ||
        (state.status == CommentsItemsStatus.loading) ||
        (state.status == CommentsItemsStatus.error && !retry)) {
      return;
    }
    emit(state.copyWith(status: CommentsItemsStatus.loading));

    DataResponse<PageResponse<Comment>> comments =
        await repository.getComments(id: mediaId, page: page);

    if (comments is DataSuccess) {
      emit(state.copyWith(
        status: CommentsItemsStatus.success,
        comments: List.of(state.comments)..addAll(comments.data?.results ?? []),
        lastPage: comments.data?.totalPages,
        nextPage: page + 1,
        error: null,
      ));
    } else {
      emit(state.copyWith(
          status: CommentsItemsStatus.error,
          error: ErrorEntity(
              title: "خطا در دریافت نظرات",
              error: comments.error ?? "خطا در دسترسی به اینترنت",
              code: comments.code)));
    }
  }

  Future<void> submitComment({required String comment}) async {
    DataResponse<void> rates =
    await repository.submitComment(id: mediaId, comment: comment);

    if (rates is DataSuccess) {
      emit(state.copyWith(
          status: CommentsItemsStatus.submitSuccess, error: null));
    } else {
      emit(state.copyWith(
          status: CommentsItemsStatus.submitError,
          error: ErrorEntity(
              title: "خطا در ثبت نظر",
              error: rates.error ?? "خطا در دسترسی به اینترنت",
              code: rates.code)));
    }
  }
}
