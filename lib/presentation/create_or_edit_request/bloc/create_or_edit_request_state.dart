

abstract class CreateOrEditRequestState {}

class CreateOrEditRequestInitial extends CreateOrEditRequestState {}

class CreateOrEditRequestLoading extends CreateOrEditRequestState {}

class CreateOrEditRequestSucceeded extends CreateOrEditRequestState {}

class CreateOrEditRequestFailed extends CreateOrEditRequestState {
  final Exception exception;

  CreateOrEditRequestFailed(this.exception);
}
