abstract class UpdateState {}

class InitialUploadingState extends UpdateState {}

class UpdatedUploadedState extends UpdateState {
  final String? success;
  UpdatedUploadedState({required this.success});
}

class UpdateErrorState extends UpdateState {
  final String? error;
  UpdateErrorState({required this.error});
}

class UpdateUploadingState extends UpdateState {}
