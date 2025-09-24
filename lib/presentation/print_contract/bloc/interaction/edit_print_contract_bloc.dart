import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/entity_models/enums/payment_status.dart';
import 'package:reconstructitapp/domain/entity_models/enums/print_contract_status.dart';
import 'package:reconstructitapp/domain/entity_models/enums/shipping_status.dart';
import 'package:reconstructitapp/domain/entity_models/payment.dart';
import 'package:reconstructitapp/domain/services/payment_service.dart';
import 'package:reconstructitapp/domain/services/print_contract_service.dart';

import '../../../../domain/entity_models/print_contract.dart';
import 'edit_print_contract_event.dart';
import 'edit_print_contract_state.dart';

/// Bloc to edit attributes of the print contract and payment from the stepper
class EditPrintContractBloc
    extends Bloc<EditPrintContractEvent, EditPrintContractState> {
  final PrintContractService printContractService;
  final PaymentService paymentService;

  EditPrintContractBloc(this.printContractService, this.paymentService)
      : super(EditPrintContractInitial()) {
    on<CancelOffer>(_onCancelOffer);
    on<AcceptOfferStep2>(_onAcceptOfferStep2);
    on<ConfirmAddressStep3>(_onConfirmAddressStep3);
    on<ConfirmPaymentOutgoingStep4>(_onConfirmPaymentOutgoingStep4);

    on<ConfirmPaymentIngoingStep5>(_onConfirmPaymentIngoingStep5);

    on<ConfirmDonePrintingStep6>(_onConfirmDonePrintingStep6);
    on<ConfirmSendingStep7>(_onConfirmSendingStep7);
    on<ConfirmReceivingStep8>(_onConfirmReceivingStep8);
  }

  void _onCancelOffer(CancelOffer event, emit) async {
    emit(EditPrintContractLoading());
    // edit Print Contract
    PrintContract printContract = PrintContract(
      event.printContract.id,
      PrintContractStatus.cancelled,
      event.printContract.shippingStatus,
      event.printContract.paymentId,
      event.printContract.revealedAddressId,
      event.printContract.communityPrintRequestId,
    );
    var result = await printContractService.updatePrintContract(printContract);
    if (result.isSuccessful) {
      emit(EditPrintContractSucceeded(cancelled: true));
    } else {
      emit(EditPrintContractFailed(result.failure!));
    }
  }

  void _onAcceptOfferStep2(AcceptOfferStep2 event, emit) async {
    emit(EditPrintContractLoading());
    // edit Print Contract
    PrintContract printContract = PrintContract(
      event.printContract.id,
      PrintContractStatus.accepted,
      event.printContract.shippingStatus,
      event.printContract.paymentId,
      event.printContract.revealedAddressId,
      event.printContract.communityPrintRequestId,
    );
    var result = await printContractService.updatePrintContract(printContract);
    if (result.isSuccessful) {
      emit(EditPrintContractSucceeded());
    } else {
      emit(EditPrintContractFailed(result.failure!));
    }
  }

  void _onConfirmAddressStep3(ConfirmAddressStep3 event, emit) async {
    emit(EditPrintContractLoading());
    // edit Print Contract
    PrintContract printContract = PrintContract(
      event.printContract.id,
      event.printContract.contractStatus,
      event.printContract.shippingStatus,
      event.printContract.paymentId,
      event.addressId,
      event.printContract.communityPrintRequestId,
    );
    var result = await printContractService.updatePrintContract(printContract);
    if (result.isSuccessful) {
      emit(EditPrintContractSucceeded());
    } else {
      emit(EditPrintContractFailed(result.failure!));
    }
  }

  void _onConfirmPaymentOutgoingStep4(ConfirmPaymentOutgoingStep4 event,
      emit,) async {
    emit(EditPrintContractLoading());
    // edit Print Contract
    Payment payment = Payment(
      event.payment.id,
      PaymentStatus.paymentDone,
      event.payment.paymentMethodId,
      event.payment.printContractId,
    );
    var result = await paymentService.updatePayment(payment);
    if (result.isSuccessful) {
      emit(EditPrintContractSucceeded());
    } else {
      emit(EditPrintContractFailed(result.failure!));
    }
  }

  void _onConfirmPaymentIngoingStep5(ConfirmPaymentIngoingStep5 event,
      emit,) async {
    emit(EditPrintContractLoading());
    // edit Print Contract
    Payment payment = Payment(
      event.payment.id,
      PaymentStatus.paymentConfirmed,
      event.payment.paymentMethodId,
      event.payment.printContractId,
    );
    var result = await paymentService.updatePayment(payment);
    if (result.isSuccessful) {
      emit(EditPrintContractSucceeded());
    } else {
      emit(EditPrintContractFailed(result.failure!));
    }
  }


  void _onConfirmDonePrintingStep6(ConfirmDonePrintingStep6 event, emit) async {
    emit(EditPrintContractLoading());
    // edit Print Contract
    PrintContract printContract = PrintContract(
      event.printContract.id,
      PrintContractStatus.printed,
      event.printContract.shippingStatus,
      event.printContract.paymentId,
      event.printContract.revealedAddressId,
      event.printContract.communityPrintRequestId,
    );
    var result = await printContractService.updatePrintContract(printContract);
    if (result.isSuccessful) {
      emit(EditPrintContractSucceeded());
    } else {
      emit(EditPrintContractFailed(result.failure!));
    }
  }

  void _onConfirmSendingStep7(ConfirmSendingStep7 event, emit) async {
    emit(EditPrintContractLoading());
    // edit Print Contract
    PrintContract printContract = PrintContract(
      event.printContract.id,
      event.printContract.contractStatus,
      ShippingStatus.sent,
      event.printContract.paymentId,
      event.printContract.revealedAddressId,
      event.printContract.communityPrintRequestId,
    );
    var result = await printContractService.updatePrintContract(printContract);
    if (result.isSuccessful) {
      emit(EditPrintContractSucceeded());
    } else {
      emit(EditPrintContractFailed(result.failure!));
    }
  }

  void _onConfirmReceivingStep8(ConfirmReceivingStep8 event, emit) async {
    emit(EditPrintContractLoading());
    // edit Print Contract
    PrintContract printContract = PrintContract(
      event.printContract.id,
      PrintContractStatus.done,
      ShippingStatus.received,
      event.printContract.paymentId,
      event.printContract.revealedAddressId,
      event.printContract.communityPrintRequestId,
    );
    var result = await printContractService.updatePrintContract(printContract);
    if (result.isSuccessful) {
      emit(EditPrintContractSucceeded());
    } else {
      emit(EditPrintContractFailed(result.failure!));
    }
  }
}
