

abstract class CreateOrEditUserState {}

class CreateOrEditUserInitial extends CreateOrEditUserState {}

class CreateOrEditUserLoading extends CreateOrEditUserState {}

class CreateOrEditUserSucceeded extends CreateOrEditUserState {
  final bool created;
  final String message;

  CreateOrEditUserSucceeded(this.message, this.created);
}

class CreateOrEditUserFailed extends CreateOrEditUserState {
  final Exception exception;

  CreateOrEditUserFailed(this.exception);
}
