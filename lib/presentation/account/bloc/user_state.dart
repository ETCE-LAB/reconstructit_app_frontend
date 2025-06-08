
import '../../../domain/entity_models/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);
}

class UserNotExisting extends UserState{}

class UserFailed extends UserState {
  final Exception exception;

  UserFailed(this.exception);
}
