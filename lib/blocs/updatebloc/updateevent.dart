import 'package:simplebloc/data/model/postmodel.dart';

abstract class UpdateEvent {}

class UpdatePressedEvent extends UpdateEvent {
  final PostsModel? post;
  final String? id;
  UpdatePressedEvent({required this.id, required this.post});
}
