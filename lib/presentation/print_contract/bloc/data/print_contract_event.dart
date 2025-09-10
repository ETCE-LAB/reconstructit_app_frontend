class PrintContractEvent {}

class PrintContractRefresh extends PrintContractEvent {
  final String printContractId;

  PrintContractRefresh({required this.printContractId});
}
