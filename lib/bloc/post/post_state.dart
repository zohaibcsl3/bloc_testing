import 'package:bloc_testing/model/post_comments_model.dart';
import 'package:equatable/equatable.dart';

enum PostStatus {
  loading,
  success,
  failure,
  error,
}

class PostState extends Equatable {
  final List<CommentsModel>? commentsList;
  final PostStatus? postStatus;

  const PostState({
    this.commentsList = const <CommentsModel>[],
    this.postStatus = PostStatus.loading,
  });

  PostState copyWith(
      {List<CommentsModel>? commentsList, PostStatus? postStatus}) {
    return PostState(
      commentsList: commentsList ?? this.commentsList,
      postStatus: postStatus ?? this.postStatus,
    );
  }

  @override
  List<Object?> get props => [
        commentsList,
      ]; // Correct implementation of props
}
