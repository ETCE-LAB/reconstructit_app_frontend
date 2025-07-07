abstract class RequestDetailState {}

class RequestDetailInitial extends RequestDetailState {}

class RequestDetailLoading extends RequestDetailState {}

class RequestDetailLoaded extends RequestDetailState {
  final bool alreadyHasChat;

  RequestDetailLoaded(this.alreadyHasChat);
}

class RequestDetailFailed extends RequestDetailState {
  final Exception exception;

  RequestDetailFailed(this.exception);
}
