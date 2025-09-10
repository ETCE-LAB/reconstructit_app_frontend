import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

abstract class PrintContractState {}

class PrintContractInitial extends PrintContractState {}

class PrintContractLoaded extends PrintContractState {
  final PrintContractViewModel printContractViewModel;

  PrintContractLoaded(this.printContractViewModel);
}

class PrintContractFailed extends PrintContractState {
  final Exception exception;

  PrintContractFailed(this.exception);
}
