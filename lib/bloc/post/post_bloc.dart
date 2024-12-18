import 'package:bloc/bloc.dart';
import 'package:bloc_testing/bloc/post/post_event.dart';
import 'package:bloc_testing/bloc/post/post_state.dart';
import 'package:bloc_testing/repository/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<FetchDataEvent>(fetchDataFromApi);
  }

  void fetchDataFromApi(FetchDataEvent event, Emitter<PostState> emit) async {
    await PostRepository().fetchPost().then((value) {
      emit(
        state.copyWith(postStatus: PostStatus.success, commentsList: value),
      );
    }).onError((error, stackTrace) {
      emit(state.copyWith(
        postStatus: PostStatus.failure,
      ));
    });
  }
}
