part of 'comments_items_cubit.dart';

enum CommentsItemsStatus {
  initial,
  loading,
  success,
  error,
  submitSuccess,
  submitError;
}

class CommentsItemsState {
  final CommentsItemsStatus status;
  final List<Comment> comments;
  final int nextPage;
  final int lastPage;
  final int total;
  final ErrorEntity? error;

  CommentsItemsState(
      {required this.status,
      required this.comments,
      required this.nextPage,
      required this.lastPage,
      required this.total,
      required this.error});

  CommentsItemsState.init(this.comments, this.total)
      : status = CommentsItemsStatus.initial,
        nextPage = 2,
        lastPage = (comments.length == total) ? 1 : 2,
        error = null;

  CommentsItemsState copyWith({
    CommentsItemsStatus? status,
    List<Comment>? comments,
    int? nextPage,
    int? lastPage,
    int? total,
    ErrorEntity? error,
  }) {
    return CommentsItemsState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      nextPage: nextPage ?? this.nextPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
      error: error ?? this.error,
    );
  }
}
