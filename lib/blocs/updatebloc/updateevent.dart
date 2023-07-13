import 'package:simplebloc/data/model/postmodel.dart';

abstract class UpdateEvent {}

class UpdatePressedEvent extends UpdateEvent {
  final PostsModel? postsModel;
  UpdatePressedEvent({required this.postsModel});
}
