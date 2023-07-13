import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplebloc/blocs/updatebloc/updateevent.dart';
import 'package:simplebloc/blocs/updatebloc/updatestate.dart';
import 'package:simplebloc/data/repository/postrepository.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final PostRepository postRepository;

  UpdateBloc(this.postRepository) : super(InitialUploadingState()) {
    on<UpdatePressedEvent>((event, emit) async {
      emit(UpdateUploadingState());
      try {
        final result =
            await postRepository.updatePost(id: event.id!, pm: event.post!);

        if (result != null) {
          emit(UpdatedUploadedState(success: 'Post updated succefully'));
        }
      } catch (err) {
        emit(UpdateErrorState(error: err.toString()));
      }
    });
  }
}
