abstract class EditPrintContractState {}

class EditPrintContractInitial extends EditPrintContractState {}


class EditPrintContractLoading extends EditPrintContractState {}

class EditPrintContractSucceeded extends EditPrintContractState {
  final bool cancelled;
  EditPrintContractSucceeded({ this.cancelled = false});
}

class EditPrintContractFailed extends EditPrintContractState {
  final Exception exception;

  EditPrintContractFailed(this.exception);
}
