import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplebloc/blocs/postbloc/postevent.dart';
import 'package:simplebloc/blocs/postbloc/poststate.dart';
import 'package:simplebloc/data/repository/postrepository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository _postRepository;
  PostBloc(this._postRepository) : super(LoadingPostState()) {
    on<LoadPostEvent>((event, emit) async {
      emit(LoadingPostState());

      try {
        final posts = await _postRepository.fetchPost();
        emit(LoadedPostState(posts));
      } catch (err) {
        emit(ErrorPostState(err.toString()));
      }
    });
  }
}
