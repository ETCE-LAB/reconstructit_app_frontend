abstract class CreatePrintContractState {}

class CreatePrintContractInitial extends CreatePrintContractState {}

class CreatePrintContractLoading extends CreatePrintContractState {}

class CreatePrintContractSucceeded extends CreatePrintContractState {
  final String printContractId;

  CreatePrintContractSucceeded({required this.printContractId});
}

class CreatePrintContractFailed extends CreatePrintContractState {
  final Exception exception;

  CreatePrintContractFailed(this.exception);
}
