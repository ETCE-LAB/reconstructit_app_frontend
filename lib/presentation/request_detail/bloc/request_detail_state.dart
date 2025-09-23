abstract class RequestDetailState {}

class RequestDetailInitial extends RequestDetailState {}

class RequestDetailLoading extends RequestDetailState {}

class RequestDetailLoaded extends RequestDetailState {
  final String? printContractId;

  RequestDetailLoaded({required this.printContractId});
}

class RequestDetailFailed extends RequestDetailState {
  final Exception exception;

  RequestDetailFailed(this.exception);
}
