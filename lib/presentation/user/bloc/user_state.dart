
import 'package:reconstructitapp/domain/entity_models/address.dart';

import '../../../domain/entity_models/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final Address? address;
  final User user;
  UserLoaded(this.user, this.address);
}

class UserNotExisting extends UserState{}

class UserFailed extends UserState {
  final Exception exception;

  UserFailed(this.exception);
}
