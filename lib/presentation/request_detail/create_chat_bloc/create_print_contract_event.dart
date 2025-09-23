class CreatePrintContractEvent {}

class CreatePrintPaymentViewModel {
  final String paymentValue;
  final String paymentAttributeId;

  const CreatePrintPaymentViewModel({
    required this.paymentValue,
    required this.paymentAttributeId,
  });
}

class CreatePrintContract extends CreatePrintContractEvent {
  final String communityPrintRequestId;
  final String otherUserId;
  final String paymentMethodId;
  final List<CreatePrintPaymentViewModel> paymentValues;

  CreatePrintContract({
    required this.communityPrintRequestId,
    required this.otherUserId,
    required this.paymentMethodId,
    required this.paymentValues,
  });
}
