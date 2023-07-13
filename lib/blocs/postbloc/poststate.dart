import 'package:simplebloc/data/model/postmodel.dart';

abstract class PostState {}

class LoadingPostState extends PostState {}

class LoadedPostState extends PostState {
  final List<PostsModel> post;
  LoadedPostState(this.post);
}

class ErrorPostState extends PostState {
  final String errorMessage;
  ErrorPostState(this.errorMessage);
}
