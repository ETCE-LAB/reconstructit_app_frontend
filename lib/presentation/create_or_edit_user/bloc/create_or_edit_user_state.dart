

abstract class CreateOrEditUserState {}

class CreateOrEditUserInitial extends CreateOrEditUserState {}

class CreateOrEditUserLoading extends CreateOrEditUserState {}

class CreateOrEditUserSucceeded extends CreateOrEditUserState {
  final String message;

  CreateOrEditUserSucceeded(this.message);
}

class CreateOrEditUserFailed extends CreateOrEditUserState {
  final Exception exception;

  CreateOrEditUserFailed(this.exception);
}
