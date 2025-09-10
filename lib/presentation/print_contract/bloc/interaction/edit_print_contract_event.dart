import '../../../../domain/entity_models/payment.dart';
import '../../../../domain/entity_models/print_contract.dart';

class EditPrintContractEvent {}

class CancelOffer extends EditPrintContractEvent {
  final PrintContract printContract;

  CancelOffer({required this.printContract});
}

class AcceptOfferStep2 extends EditPrintContractEvent {
  final PrintContract printContract;

  AcceptOfferStep2({required this.printContract});
}

class ConfirmAddressStep3 extends EditPrintContractEvent {
  final PrintContract printContract;
  final String addressId;

  ConfirmAddressStep3({required this.printContract, required this.addressId});
}

class ConfirmPaymentOutgoingStep4 extends EditPrintContractEvent {
  final Payment payment;

  ConfirmPaymentOutgoingStep4({required this.payment});
}

class ConfirmPaymentIngoingStep5 extends EditPrintContractEvent {
  final Payment payment;

  ConfirmPaymentIngoingStep5({required this.payment});
}

class ConfirmDonePrintingStep6 extends EditPrintContractEvent {
  final PrintContract printContract;

  ConfirmDonePrintingStep6({required this.printContract});
}

class ConfirmSendingStep7 extends EditPrintContractEvent {
  final PrintContract printContract;

  ConfirmSendingStep7({required this.printContract});
}

class ConfirmReceivingStep8 extends EditPrintContractEvent {
  final PrintContract printContract;

  ConfirmReceivingStep8({required this.printContract});
}
