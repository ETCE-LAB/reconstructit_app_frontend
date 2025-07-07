abstract class CreateChatState {}

class CreateChatInitial extends CreateChatState {}

class CreateChatLoading extends CreateChatState {}

class CreateChatSucceeded extends CreateChatState {
}

class CreateChatFailed extends CreateChatState {
  final Exception exception;

  CreateChatFailed(this.exception);
}
