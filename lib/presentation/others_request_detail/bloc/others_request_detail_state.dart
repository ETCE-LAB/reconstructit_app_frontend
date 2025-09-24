abstract class OthersRequestDetailState {}

class OthersRequestDetailInitial extends OthersRequestDetailState {}

class OthersRequestDetailLoading extends OthersRequestDetailState {}

class OthersRequestDetailLoaded extends OthersRequestDetailState {
  final String? printContractId;

  OthersRequestDetailLoaded({required this.printContractId});
}

class OthersRequestDetailFailed extends OthersRequestDetailState {
  final Exception exception;

  OthersRequestDetailFailed(this.exception);
}
