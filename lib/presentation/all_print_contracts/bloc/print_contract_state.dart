import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

abstract class AllPrintContractsState {}

class AllPrintContractsInitial extends AllPrintContractsState {}
class AllPrintContractsLoading extends AllPrintContractsState {}


class AllPrintContractsLoaded extends AllPrintContractsState {
  final List<PrintContractViewModel> printContractViewModels;

  AllPrintContractsLoaded(this.printContractViewModels);
}

class AllPrintContractsFailed extends AllPrintContractsState {
  final Exception exception;

  AllPrintContractsFailed(this.exception);
}
