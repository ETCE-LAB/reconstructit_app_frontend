

abstract class InitialState {}

class InitialInitial extends InitialState {}

class InitialLoading extends InitialState {}

class InitialLoaded extends InitialState {
  final bool alreadyStarted;

  InitialLoaded(this.alreadyStarted);
}
